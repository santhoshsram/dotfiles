# Global Claude Code rules

Working-discipline rules for all repositories. Subagents don't inherit this
file or session context — they act only on their spawn prompt. So these are
reminders for me (the orchestrator) when writing subagent prompts and doing
git work.

## Parallel subagents in git worktrees

Use `isolation: "worktree"` so parallel agents never share a directory. The
spawn prompt must cover worktree behavior or you get branch sprawl and churn:

- A worktree starts on an auto branch `worktree-agent-<id>`. Don't have the
  agent run `git checkout -b` — that leaves two branches per fix. First
  action: `git branch -m worktree-agent-<id> fix/<issue>-<slug>`, then work
  and push that one branch. Supply the target branch name in the prompt.
- Tell the agent it's in a worktree; it must edit worktree-relative paths,
  not absolute shared-checkout paths (those get rejected, risking a no-op
  commit before the real fix).
- A fresh worktree has no installed dependencies. Have the agent install them
  before running tests/lint, or stray tool versions make tests silently
  no-op and trigger repeated force-pushes.
- No background-poll or connectivity-probe calls (e.g. `echo ping`, `pwd`,
  `echo alive`). Run work synchronously.

## Sequential git/worktree teardown

Run git state mutations (worktree remove/unlock, branch delete, push
--delete, bulk cleanup, rebase/reset) one at a time. Never fire parallel or
duplicate git mutations — one locked/errored call cancels the whole batch,
wasting retries.

- Chain steps in one script with `&&`/`;`, not parallel calls.
- Locked worktree: `git worktree unlock <path>`, then
  `git worktree remove -f -f <path>`, then `git worktree prune`.
- Parallel tool calls only for independent, non-conflicting reads.

## Writing style

The only dash to use in anything you write (commit messages, PR titles and
bodies, comments, docs, chat) is the plain keyboard hyphen `-` (the key next
to `0`, U+002D). Never use the em-dash `—` (U+2014) or en-dash `–` (U+2013).
Recast with a colon, comma, parens, or two sentences instead.

## Commit & PR title convention

Commit subjects and PR titles follow Conventional Commits
(https://www.conventionalcommits.org). In squash-merge repos the PR title
becomes the commit subject, so keep them in sync.

```
type(scope): short, imperative description (#issue[, #issue...])

feat(auth): add refresh-token rotation (#142)
fix(checkout/cart): stop double-charge on retry (#418, #420)
```

- type: one of `feat`, `fix`, `perf`, `refactor`, `chore`, `docs`, `ci`,
  `test`, `build`, `revert`. Pick by intent, not area; a simulation or
  diagnostic change is still a `feat`/`fix`/`chore` with a `sim`/`diag` scope.
- scope: the module/service/app touched, from the directory layout
  (`operations`, `customer`, `dispatch`). Each repo's scope list lives in its
  own CONTRIBUTING.md, not here. Sub-scope with `/`
  (`feat(customer/voice)`), multiple areas with `,`
  (`fix(customer,notification)`). Optional; type alone is valid (`docs: ...`).
- description: imperative, lower-case start, no trailing period, max ~70 chars.
  Longer what/why goes in the body.
- issue refs: trailing `(#NNN)`, comma-separated for several `(#428, #452)`.
  References the issue, not the PR; squash-merge appends the PR number
  automatically, so don't pre-add it.
