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

## Commit & PR title convention

Commit subjects and PR titles follow [Conventional Commits](https://www.conventionalcommits.org):

```
type(scope): short, imperative description
```

- **type** — one of: `feat`, `fix`, `perf`, `refactor`, `chore`, `docs`,
  `ci`, `test`, `build`, `revert`. Pick by *intent*, not by area — a
  simulation or diagnostic change is still a `feat`/`fix`/`chore`; what's
  special is the scope, not the type.
- **scope** — the module/service/app the change touches, derived from the
  directory layout (e.g. `operations`, `customer`, `rider`, `dispatch`). A
  repo's specific scope vocabulary lives in *that repo's* CONTRIBUTING.md,
  not here. Conventions that hold across scopes:
  - Sub-scope with `/`: `feat(customer/voice)`, `perf(rider/notifications)`.
  - Multiple areas with `,`: `fix(customer,notification): ...`.
  - Scope is encouraged but optional; type alone is valid when nothing
    narrower fits (`docs: ...`, `chore: ...`).
- **description** — imperative mood, lower-case start, no trailing period,
  aim for ≤ ~70 chars. A longer "what/why" goes in the body, not the subject.

### Trailing issue references

End the subject with the issue(s) the change closes, in parens:

```
fix(dispatch): de-org geo-index + rugged search loop (#428, #452)
```

- Multiple issues are comma-separated inside one paren group: `(#428, #452)`.
- This references the *issue*, not the PR. On squash-merge, GitHub appends
  the *PR* number automatically (`… (#453)`), so the merged subject may carry
  both — that's expected, don't pre-add the PR number.

The PR **title** uses the exact same grammar (it becomes the squash-merge
commit subject). Keep PR title and the primary commit subject in sync.
