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
