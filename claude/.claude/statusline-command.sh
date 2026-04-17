#!/usr/bin/env bash
input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // "unknown"')
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
folder=$(basename "$cwd")

# Git branch (skip optional lock)
git_branch=""
if git_branch_raw=$(GIT_OPTIONAL_LOCKS=0 git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null); then
  git_branch="$git_branch_raw"
elif git_branch_raw=$(GIT_OPTIONAL_LOCKS=0 git -C "$cwd" rev-parse --short HEAD 2>/dev/null); then
  git_branch="$git_branch_raw"
fi

# Session duration: use total_duration_ms from cost object
duration_ms=$(echo "$input" | jq -r '.cost.total_duration_ms // empty')
duration_str=""
if [ -n "$duration_ms" ] && [ "$duration_ms" -gt 0 ] 2>/dev/null; then
  elapsed=$(( duration_ms / 1000 ))
  minutes=$(( elapsed / 60 ))
  seconds=$(( elapsed % 60 ))
  if [ "$minutes" -ge 60 ]; then
    hours=$(( minutes / 60 ))
    mins=$(( minutes % 60 ))
    duration_str="${hours}h${mins}m"
  elif [ "$minutes" -gt 0 ]; then
    duration_str="${minutes}m${seconds}s"
  else
    duration_str="${seconds}s"
  fi
fi

# Total cost: use the pre-calculated cost from Claude Code
cost_raw=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')
if [ -n "$cost_raw" ]; then
  cost=$(printf "%.2f" "$cost_raw")
else
  cost="0.00"
fi

# Context window usage: visual progress bar (10 blocks wide)
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
if [ -n "$used_pct" ]; then
  used_int=$(printf "%.0f" "$used_pct")
  filled=$(( used_int / 10 ))
  empty_blocks=$(( 10 - filled ))
  bar=""
  for i in $(seq 1 $filled); do bar="${bar}█"; done
  for i in $(seq 1 $empty_blocks); do bar="${bar}░"; done
  context_str="${bar} ${used_int}%"
else
  context_str=""
fi

parts="🧠 ${model}"
[ -n "$duration_str" ] && parts="${parts} | ⏱️ ${duration_str}"
parts="${parts} | \$${cost}"
[ -n "$context_str" ] && parts="${parts} | ${context_str}"
parts="${parts} | 📂 ${folder}"
[ -n "$git_branch" ] && parts="${parts} | 🌿 ${git_branch}"

printf "%s" "$parts"
