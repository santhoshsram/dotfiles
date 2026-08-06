# Global Claude Code rules

Subagents don't inherit this file; they act only on their spawn prompt, so
put any rule below that a subagent needs into its spawn prompt.

## Editing files

Use the built-in tools: Edit, Write, NotebookEdit. Never edit files with a
script (`python3`, `sed -i`, `perl -pi`, `awk`) - a missed match exits 0 and
silently no-ops, where the built-in tools error. Shell is for grep, build,
format, test, git.

## Parallel subagents in git worktrees

Use `isolation: "worktree"` so parallel agents never share a directory. The
spawn prompt must cover worktree behavior or you get branch sprawl:

- Worktree starts on auto branch `worktree-agent-<id>`. Don't have the agent
  `git checkout -b` (leaves two branches per fix). First action:
  `git branch -m worktree-agent-<id> fix/<issue>-<slug>`, then work and push
  that one branch. Supply the target name in the prompt.
- Tell the agent it's in a worktree; edit worktree-relative paths, not absolute
  shared-checkout paths (those get rejected, risking a no-op commit).
- Fresh worktree has no deps installed. Have the agent install before
  tests/lint, or stray tool versions make tests silently no-op.
- No background-poll/connectivity probes (`echo ping`, `pwd`). Run
  synchronously.

## Sequential git/worktree teardown

Run git state mutations (worktree remove/unlock, branch delete, push
--delete, rebase/reset) one at a time. Never parallel or duplicate: one
locked/errored call cancels the whole batch.

- Chain steps in one script with `&&`/`;`, not parallel calls.
- Locked worktree: `git worktree unlock <path>`, then
  `git worktree remove -f -f <path>`, then `git worktree prune`.
- Parallel tool calls only for independent, non-conflicting reads.

## Memory file location

Project memory has ONE home: absolute `~/.claude/projects/<project-slug>/memory/`
(path the harness names in the session prompt). Never a repo-relative path: the
slug embeds the repo path, so relative `memory/` resolves *inside the working
repo* and spawns an in-repo twin that drifts and gets committed by accident.
Expand to absolute `~/.claude/...` before any write. Fold any existing twin back
into the canonical store and delete it.

## Writing style

Only dash to use anywhere (commits, PR titles/bodies, comments, docs, chat) is
the plain hyphen `-` (U+002D). Never the em-dash `—` (U+2014) or en-dash `–`
(U+2013). Recast with colon, comma, parens, or two sentences.

## Code comments

A comment serves the next reader of the file, not the diff. Explain why the
code is the way it is, never how it got there.

- No change-history narration ("added later because X"). Git holds that.
- No restating the code (`// increment i`).
- No issue/PR refs (`#NNN`): a ref is diff-witness narration, not a why.
- Do capture: non-obvious intent, a non-local constraint, why this over the obvious alternative. No such why? Leave it uncommented.
- Keep it short and tight. Say the why in as few words as it takes, no padding.

## Commit & PR title convention

Conventional Commits (conventionalcommits.org). Squash-merge repos: PR title
becomes the commit subject, so keep them in sync.

```
type(scope): short, imperative description (#issue[, #issue...])

feat(auth): add refresh-token rotation (#142)
fix(checkout/cart): stop double-charge on retry (#418, #420)
```

- type: `feat`, `fix`, `perf`, `refactor`, `chore`, `docs`, `ci`, `test`,
  `build`, `revert`. Pick by intent, not area; a sim/diag change is still a
  `feat`/`fix`/`chore` with a `sim`/`diag` scope.
- scope: the module/service/app touched, from the directory layout
  (`operations`, `customer`). Each repo's scope list lives in its own
  CONTRIBUTING.md. Sub-scope with `/` (`feat(customer/voice)`), multiple areas
  with `,`. Optional; type alone is valid.
- description: imperative, lower-case start, no trailing period, max ~70 chars.
  Longer what/why goes in the body.
- issue refs: trailing `(#NNN)`, comma-separated. References the issue, not the
  PR; squash-merge appends the PR number, so don't pre-add it.
- PR body: add `Closes #NNN` (or `Fixes`/`Resolves`) on its own line for each
  issue the PR fully fixes. This links the issue in GitHub's Development panel
  so it auto-closes on merge; a bare `(#NNN)` mention does not close it. If the
  PR only partly fixes an issue, mention it without the closing keyword.
- Stage explicit paths, never `git add -A` / `git add .` (they sweep in
  untracked scratchpad notes and freshly-built binaries the user didn't mean to
  commit). If asked to commit, list the files.

## Authoring plugins are scoped off

Authoring-only plugins `plugin-dev`, `agent-sdk-dev`, `skill-creator` are off
at user scope, on only in `~/projects/santhosh-claude-plugins` via its
`settings.local.json`: intentional context-trim, not breakage.

## UI automation: read the element tree, not screenshots

- To discover/navigate a UI, read the structural element tree; far faster than
  the screenshot-then-review loop.
- playwright: `browser_snapshot`, interact via element refs.
- mobile-mcp: `mobile_list_elements_on_screen`, then tap returned coords with
  `mobile_click_on_screen_at_coordinates` (no ref-based tap).
- Never read a tap coordinate off a screenshot; take coordinates from the tree.
- Screenshots are still right for: confirming an action advanced the screen,
  anything visual (colors, layout, borders, map tiles), or when the tree returns
  no actionable nodes (canvas, WebView, MapLibre).
