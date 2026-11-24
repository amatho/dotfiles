// What this copy adds to Herdr's context menus, through a few hooks in main.js:
// jj workspaces in place of worktrees, moving a pane, copy mode, Neovim, archiving
// Claude sessions, and linking PRs and issues. Its items' commands are mod names,
// opened as overlays by `extraOpen`.

import { openOverlay, exec, agents, panes } from "herdr";

const claude = (a) => !a.address.includes("/") && (a.app === "claude-code" || a.program?.key === "claude");

// A space's jj checkout: "jj-main", "jj-linked" (a jj workspace), or null outside jj.
export async function jjCheckout(folder, on) {
  const ws = await exec("jj", ["--ignore-working-copy", "--color=never", "workspace", "root"], { cwd: folder, on });
  if (ws.code !== 0) return null;
  const linked = await exec("test", ["-f", `${ws.stdout.trim()}/.jj/repo`], { on });
  return linked.code === 0 ? "jj-linked" : "jj-main";
}

// The pane menu's items, before "Close pane".
export function paneItems(tg, term, inTab) {
  const cwd = panes().find((pane) => pane.pane === tg.pane)?.cwd;
  return [
    ...(inTab && term
      ? [
          ["Move to new tab", "custom-panes", { action: "tab", terminal: term.address }],
          ["Move to space…", "custom-panes", { action: "space", terminal: term.address }],
          ["Copy mode", "custom-copy", { action: "copy", terminal: term.address }],
          ["Open in Neovim", "custom-copy", { action: "nvim", terminal: term.address, cwd }],
          ["Open in Neovim with colours", "custom-copy", { action: "nvim", colors: true, terminal: term.address, cwd }],
        ]
      : []),
    ...(inTab && agents().some((a) => a.address === tg.terminal && claude(a)) ? [["Archive session", "custom-sessions", { action: "archive", terminals: [tg.terminal] }]] : []),
  ];
}

// The space menu's jj workspace items, in place of its worktree ones.
export function jjItems(tg, git) {
  return [
    ["New jj workspace", "custom-jj-workspace", { space: tg.id, action: "new" }],
    ["Open jj workspace", "custom-jj-workspace", { space: tg.id, action: "open" }],
    ...(git === "jj-linked" ? [["Remove jj workspace", "custom-jj-workspace", { space: tg.id, action: "remove" }]] : []),
  ];
}

// The space menu's items, before "Close".
export function spaceItems(tg) {
  return [
    ["Link PR or issue…", "custom-spaces", { link: tg.id }],
    ...(agents().some((a) => a.space === tg.id && claude(a)) ? [["Archive sessions & close", "custom-sessions", { action: "archive", space: tg.id }]] : []),
  ];
}

export function extraIcon(command) {
  if (command === "custom-spaces") return "mods/custom-spaces/git-pull-request.svg";
  const name = command === "custom-jj-workspace" ? "git-branch" : command === "custom-sessions" ? "archive" : command === "custom-panes" ? "layers" : command === "custom-copy" ? "file-text" : null;
  return name && `mods/workspace-chrome/${name}.svg`;
}

// Opens an item whose command is one of these mods; false for any other.
export function extraOpen(command, args) {
  const cover = { kind: "window", frame: "none", width: 1, height: 1, at: { x: 0, y: 0 } };
  if (command === "custom-jj-workspace") openOverlay({ mod: command, kind: "dialog", ...(args.action === "open" ? { width: 560, height: 480 } : { width: 440, height: 260 }), props: args });
  else if (command === "custom-spaces") openOverlay({ mod: command, kind: "dialog", width: 560, height: 0.7, props: args });
  else if (command === "custom-sessions") openOverlay({ mod: command, kind: "dialog", width: 440, height: 220, props: args });
  else if (command === "custom-copy" && args.action === "copy") openOverlay({ mod: command, kind: "dialog", width: 0.92, height: 0.88, props: args });
  else if (command === "custom-panes" && args.action === "space") openOverlay({ mod: command, kind: "dialog", width: 420, height: 360, props: args });
  else if (command === "custom-copy" || command === "custom-panes") openOverlay({ mod: command, ...cover, props: args });
  else return false;
  return true;
}
