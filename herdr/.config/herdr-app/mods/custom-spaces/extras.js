// What this copy adds to Herdr's spaces list, through a few hooks in main.js:
// jj bookmarks where git has no branch, a count of the Claude sessions archived in
// each checkout, and its GitHub PRs and issues: linked from its menu, its branch's
// PR, and those its Claude sessions opened. This asks GitHub for all of them and
// shares what it learns as shared("github") for the link dialog.

import { svg } from "gpui-kit";
import { h_flex } from "gpui-base";
import { spaces, machines, terminals, agents, focused, nextCommand, openOverlay, exec, shared, setShared, window } from "herdr";
import { FINAL, badges, branchName, fetchGitHub, githubRepo, scanAgent } from "./github.js";

const inside = (p, dir) => p === dir || p.startsWith(dir + "/");
const ARCHIVE = "custom-sessions.archived";

// GitHub is asked again this often while the window is in front: open PRs and
// issues and branches' PRs, then merged and closed ones; after a failure, not before.
const GH_OPEN = 2 * 60000;
const GH_FINAL = 30 * 60000;
const GH_RETRY = 10 * 60000;
const machineOf = (id) => (id.includes("/") ? id.split("/")[0] : null);

// The nearest bookmarks under @, as the starship prompt shows them: "main",
// "main*~2", "2 bookmarks", "?". null outside jj.
async function bookmarkOf(cwd, on) {
  const nearest = "heads(::@ & (bookmarks() | remote_bookmarks()))";
  const log = (revs, template) => exec("jj", ["--ignore-working-copy", "--color=never", "log", "--no-graph", "-r", revs, "-T", template], { cwd, on });
  const heads = await log(nearest, 'bookmarks ++ "\\n"');
  if (heads.code !== 0) return null;
  const lines = heads.stdout.split("\n").filter(Boolean);
  if (!lines.length) return "?";
  const label = lines.length > 1 ? `${lines.length} bookmarks${lines.some((l) => l.includes("*")) ? "*" : ""}` : lines[0];
  const ahead = await log(`${nearest}..@ ~ @`, '"x"');
  return ahead.code === 0 && ahead.stdout.length ? `${label}~${ahead.stdout.length}` : label;
}

// The link dialog for a space.
function openLinks(id) {
  if (id) openOverlay({ mod: "custom-spaces", kind: "dialog", width: 560, height: 0.7, props: { link: id } });
}

export function extraInit(view, cx) {
  const gh = shared("github") ?? {};
  view.items = gh.items ?? {}; // url -> { kind, url, repo, number, title, state, at }
  view.agentLinks = gh.agents ?? {}; // terminal -> PR urls its Claude session recorded
  view.branchPrs = {}; // "owner/repo\0branch" -> { url, at }
  view.published = JSON.stringify(gh);
  view.claude = {}; // terminal -> { sid, working } at the last look
  view.scanQueue = new Set();
  view.stale = new Set(); // urls to ask GitHub about again now
  view.ghRetry = 0;
  cx.spawn(async () => {
    for (;;) if ((await nextCommand()) === "link") openLinks(focused()?.space ?? spaces().find((s) => s.active)?.id);
  });
}

// Adds to a place's git info: its folder, its GitHub repo, and its jj bookmarks
// when git is on no branch.
export async function extraGit(info, cwd, on, top, detached) {
  const origin = await exec("git", ["remote", "get-url", "origin"], { cwd, on });
  info.top = top;
  info.gh = origin.code === 0 ? githubRepo(origin.stdout) : null;
  if (detached) info.branch = (await bookmarkOf(cwd, on)) ?? info.branch;
}

// `gitOf(space)`: the space's git info, as main.js knows it.
export function extraDue(view, now, sp, gitOf, cx) {
  claudeDue(view, cx);
  githubDue(view, now, sp, gitOf, cx);
}

// Claude sessions to read for PR links: new ones, and those whose turn just ended.
function claudeDue(view, cx) {
  const seen = {};
  for (const t of terminals()) {
    const sid = t.state === "live" && t.labels?.["claude.session"];
    if (!sid) continue;
    const working = t.status === "working";
    const was = view.claude[t.address];
    seen[t.address] = { sid, working };
    if (!was || was.sid !== sid || (was.working && !working)) view.scanQueue.add(t.address);
  }
  view.claude = seen;
  const gone = Object.keys(view.agentLinks).filter((address) => !seen[address]);
  for (const address of gone) delete view.agentLinks[address];
  if (gone.length) cx.notify();
  if (!view.scanQueue.size || view.scanning) return;
  view.scanning = true;
  cx.spawn(async (cx) => {
    while (view.scanQueue.size) {
      const [address] = view.scanQueue;
      view.scanQueue.delete(address);
      const c = view.claude[address];
      if (!c) continue;
      try {
        const urls = await scanAgent(c.sid, machineOf(address));
        if (urls.length) view.agentLinks[address] = urls;
        else delete view.agentLinks[address];
        for (const url of urls) view.stale.add(url);
      } catch {}
    }
    view.scanning = false;
    cx.notify();
  });
}

// The GitHub repo and branch a space's PR would be on: "owner/repo\0branch".
function branchKey(g) {
  const branch = g?.gh && branchName(g.branch);
  return branch ? `${g.gh}\0${branch}` : null;
}

function githubDue(view, now, sp, gitOf, cx) {
  if (view.fetching || now < view.ghRetry) return;
  const active = window().active;
  const old = (at, final) => active && now - (at ?? 0) > (final ? GH_FINAL : GH_OPEN);
  const urls = [...new Set([...Object.values(shared("github.links") ?? {}).flat(), ...Object.values(view.agentLinks).flat()])]
    .filter((u) => !view.items[u] || view.stale.has(u) || old(view.items[u].at, FINAL.has(view.items[u].state)));
  const keys = [...new Set(sp.map((s) => branchKey(gitOf(s))).filter(Boolean))].filter((k) => !view.branchPrs[k] || old(view.branchPrs[k].at, false));
  if (!urls.length && !keys.length) return;
  view.fetching = true;
  for (const u of urls) view.stale.delete(u);
  cx.spawn(async (cx) => {
    try {
      const r = await fetchGitHub(urls, keys.map((key) => { const [repo, branch] = key.split("\0"); return { key, repo, branch }; }));
      Object.assign(view.items, r.items);
      for (const [k, url] of Object.entries(r.branches)) view.branchPrs[k] = { url, at: Date.now() };
      if (!r.ok) view.ghRetry = Date.now() + GH_RETRY;
    } catch {
      view.ghRetry = Date.now() + GH_RETRY;
    }
    view.fetching = false;
    cx.notify();
  });
}

// What the other mods read: every linked item's state, agents' PRs and spaces'
// branch PRs. Written only when it changed; links and hidden ones of gone spaces
// are dropped once their machine's layout is in.
export function extraPublish(view, sp, gitOf) {
  const ids = new Set(sp.map((s) => s.id));
  const ready = new Set(machines().filter((m) => m.layout === "ready").map((m) => m.name ?? null));
  const prune = (key) => {
    const all = shared(key) ?? {};
    const kept = Object.fromEntries(Object.entries(all).filter(([id, urls]) => urls?.length && (ids.has(id) || !ready.has(machineOf(id)))));
    if (Object.keys(kept).length !== Object.keys(all).length) setShared(key, kept);
    return kept;
  };
  const kept = prune("github.links");
  const hidden = prune("github.hidden");
  const branches = {};
  for (const s of sp) {
    const k = branchKey(gitOf(s));
    if (k && view.branchPrs[k]?.url) branches[s.id] = view.branchPrs[k].url;
  }
  const used = new Set([...Object.values(kept).flat(), ...Object.values(view.agentLinks).flat(), ...Object.values(branches)]);
  for (const u of Object.keys(view.items)) if (!used.has(u)) delete view.items[u];
  const gh = { items: view.items, agents: view.agentLinks, branches };
  const text = JSON.stringify(gh);
  if (text !== view.published) {
    view.published = text;
    setShared("github", gh);
  }
  // Each space's links: by hand, its branch's PR, its agents', less those hidden.
  const as = agents();
  view.links = new Map(sp.map((s) => {
    const off = new Set(hidden[s.id] ?? []);
    const auto = [branches[s.id], ...as.filter((a) => a.space === s.id).flatMap((a) => view.agentLinks[a.address] ?? [])].filter((u) => u && !off.has(u));
    return [s.id, [...new Set([...(kept[s.id] ?? []), ...auto])]];
  }));
}

// Archived Claude sessions in a checkout, leaving out those in checkouts nested inside it.
function archivedIn(path, nested = []) {
  return (shared(ARCHIVE) ?? []).filter((r) => inside(r.cwd, path) && !nested.some((p) => inside(r.cwd, p))).length;
}

// What goes at the end of a space's row: its PRs and issues, and its archived sessions.
export function extraBadges(view, w, g, tree, t) {
  const out = [];
  const links = view.links?.get(w.id);
  if (links?.length) out.push(badges(links, view.items, t, `gh-${w.id}`, 3));
  if (g?.top) {
    const count = archivedIn(g.top, tree ? [] : Object.values(view.git).filter((k) => k?.linked && k.repo === g.repo).map((k) => k.top));
    if (count > 0) out.push(h_flex().flex_none().gap(3).items_center().text_size(11.5).text_color(t.dim).child(svg("mods/workspace-chrome/archive.svg").size(11)).child(String(count)));
  }
  return out;
}
