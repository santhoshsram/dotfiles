# Aliases for starting claude code using different claude accounts. Each
# CLAUDE_CONFIG_DIR gets its own login (keychain entry is keyed to the dir)
# while symlinks share CLAUDE.md, plugins and settings. MCP servers can't
# be shared via config dir, hence --mcp-config.
alias claude-zipkee='CLAUDE_CONFIG_DIR="$HOME/.claude-zipkee" claude --mcp-config "$HOME/.mcp-shared.json"'
alias claude-personal='CLAUDE_CONFIG_DIR="$HOME/.claude-personal" claude --mcp-config "$HOME/.mcp-shared.json"'
