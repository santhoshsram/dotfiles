#!/usr/bin/env bash
input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // "unknown"')
effort=$(echo "$input" | jq -r '.effort.level // empty')
[ -n "$effort" ] && model="${model} (${effort})"
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
duration_ms=$(echo "$input" | jq -r '.cost.total_api_duration_ms // empty')
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

# Context window usage: compact percentage
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
if [ -n "$used_pct" ]; then
  used_int=$(printf "%.0f" "$used_pct")
  context_str="📖 ${used_int}% ctx"
else
  context_str=""
fi

# Rate limit (5-hour window): compact percentage
rate_limit_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
rate_limit_str=""
if [ -n "$rate_limit_pct" ]; then
  rate_int=$(printf "%.0f" "$rate_limit_pct")
  rate_limit_str="🔋 ${rate_int}% 5h"
fi

parts="🧠 ${model}"
[ -n "$duration_str" ] && parts="${parts} | ⏱️ ${duration_str}"

# Always show rate limit (Max plan — no per-token billing)
[ -n "$rate_limit_str" ] && parts="${parts} | ${rate_limit_str}"

[ -n "$context_str" ] && parts="${parts} | ${context_str}"
parts="${parts} | 📂 ${folder}"
[ -n "$git_branch" ] && parts="${parts} | 🌿 ${git_branch}"

printf "%s" "$parts"
