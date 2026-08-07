# Global instructions
Limit the amount of comments you put in the code to a strict minimum. You should almost never add comments, except sometimes on non-trivial code, function definitions if the arguments aren't self-explanatory, and class definitions and their members.

Do not remove existing comments unless they are directly related to what you are changing.

# Version control

I generally use [Jujutsu (`jj`)](https://jj-vcs.github.io/jj/) for version control, not raw `git`.

- Prefer `jj` commands over `git` commands for everyday version control work (status, diffing, committing, log, branches/bookmarks, rebasing, etc.).
- Many of my repos are colocated (`jj` on top of a `.git` backend), so a `.git` directory existing does **not** mean I want git commands. Check for a `.jj` directory before assuming git.
- In `jj` there is no staging area and the working copy is always a commit. Don't reach for `git add` / `git commit`; describe the working-copy commit with `jj describe` (or `jj commit`) and create new ones with `jj new`.

## Common command mapping

| Task | git | jj |
| --- | --- | --- |
| Show status | `git status` | `jj st` |
| Show history | `git log` | `jj log` |
| Diff working changes | `git diff` | `jj diff` |
| Record a change | `git commit` | `jj commit` / `jj describe` |
| Start a new change | (branch + commit) | `jj new` |
| Update a message | `git commit --amend` | `jj describe` |
| Move a branch pointer | branches | `jj bookmark` |
| Rebase | `git rebase` | `jj rebase` |
| Push to a remote | `git push` | `jj git push` |
| Fetch from a remote | `git fetch` | `jj git fetch` |

Notes:
- `jj` uses **bookmarks** rather than git-style branches; remote interaction goes through `jj git push` / `jj git fetch`.
- Don't auto-commit or push unless I ask. When I do ask, use the `jj` equivalents above.
- If a repo turns out to be git-only (no `.jj` directory), fall back to git.
