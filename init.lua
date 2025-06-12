-- Setup lazy.vim
require("config.lazy")
-- Set python3 host program
vim.g.python3_host_prog = '/Users/santhosh/.pyenv/versions/py-neovim/bin/python'

-- General Settings
vim.opt.autoindent = true                       -- Always set autoindenting on
vim.opt.backspace = {'indent', 'eol', 'start'}  -- Backspace over everything in insert mode
vim.opt.cinoptions = 'g0,t0,c1s,(0,m1,l1'       -- C indent options. See :help cinoptions-values
vim.opt.cinwords:append('case')                 -- C indent keywords
vim.opt.cursorline = true                       -- Highlight cursorline
vim.opt.expandtab = true                        -- Replace <tab> with tabstop spaces in insert mode
vim.opt.formatoptions = '2ntcroqlv'             -- Auto formatting. See :help fo-table
vim.opt.hidden = true                           -- Keep unchanged
vim.opt.history = 100                           -- Keep 100 lines of command line history
vim.opt.hlsearch = true                         -- Highlight search matches
vim.opt.incsearch = true                        -- Display matches while typing pattern
vim.opt.laststatus = 2                          -- Always display status line
vim.opt.magic = true                            -- Interpret special characters in pattern matching
vim.opt.backup = false                          -- Do not keep a backup file
vim.opt.compatible = false                      -- Use vim mode and not vi compatibility mode
                                                -- Note: Always have this at the very beginning
                                                -- of the file as the first config line.
vim.opt.errorbells = false                      -- Don't beep on errors
vim.opt.startofline = false                     -- Don't jump to start of line during page up/down
vim.opt.wrapscan = false                        -- Don't wrap searches around end of file
vim.opt.ruler = true                            -- Always show cursor position in statusbar
vim.opt.scrolloff = 2                           -- Always show 2 lines above and below the cursor
vim.opt.shiftwidth = 3                          -- Num spaces to use for each indent
vim.opt.showcmd = true                          -- Display incomplete commands in the last line
vim.opt.showmatch = true                        -- Show matching braces
vim.opt.showmode = true                         -- Show current mode in status line
vim.opt.smarttab = true                         -- Insert tab based on shiftwidth, at line beginning
vim.opt.splitright = true                       -- Show the cscope search result on the right
                                                -- for vertical splits
vim.opt.termguicolors = true                    -- Enable true colors (was t_Co=256 for 256 color support)
vim.opt.tabstop = 3                             -- Set tab to 3 spaces
vim.opt.textwidth = 140                         -- Break lines longer than 140 chars
vim.opt.visualbell = true                       -- Don't flash screen on errors (was visualbell t_vb=)
vim.opt.whichwrap = 'b,s,h,l,<,>,[,]'           -- Wrap cursor to move next/prev lines when at end/beginning of a line
vim.opt.wildmenu = true                         -- Enhanced command line completion
vim.opt.writebackup = true                      -- Backup before overwriting, delete after writing

vim.cmd('filetype indent on')                   -- Intelligent auto-indent based on filetype
vim.cmd('filetype plugin on')                   -- Enable filetype plugin. For CCTree.vim
-- fixdel                                       -- Fix Del key behavior
vim.cmd('syntax on')                            -- Turn syntax coloring on
vim.opt.number = true                           -- Show line numbers
vim.opt.relativenumber = true                   -- Show relative line numbers. Absolute line number is shown for current line.

-- background theme
vim.opt.background = 'dark'

-- Global variables
vim.g.c_comment_strings = 1                      -- Highlight strings and number inside C comment
vim.g.c_space_errors = 1                         -- Highlight unwanted spaces

-- Highlight Groups
-- Remove bold from other common highlights
vim.api.nvim_set_hl(0, 'MatchParen', {})  -- Matching parentheses
vim.api.nvim_set_hl(0, 'Visual', {})      -- Visual selection

-- Keep catppuccin colors but remove bold from search highlights
vim.api.nvim_set_hl(0, 'Search', {})
vim.api.nvim_set_hl(0, 'IncSearch', {})

-- Highlight trailing white spaces
vim.api.nvim_set_hl(0, 'TrailingWhitespace', {
  ctermbg = 1,
  ctermfg = 1,
  bg = 'red',        -- For GUI
  fg = 'red'         -- For GUI
})

-- Match trailing whitespace (this still needs vim functions)
vim.fn.matchadd('TrailingWhitespace', [[\s\+$]])

-- Key Mappings
-- Set paste toggle
vim.keymap.set('n', '<F2>', ':set invpaste paste?<CR>', { silent = true })
vim.keymap.set('i', '<F2>', '<C-O><F2>')

vim.keymap.set('n', '<F3>', ':call ToggleRightMarginHi()<CR>', { silent = true })
vim.keymap.set('n', '<F4>', ':call ReloadCscope()<CR>', { silent = true })

-- Key binding for ShowMarks plugin
vim.keymap.set('n', '<F6>', ':ShowMarksToggle<CR>', { silent = true })

-- Enable/Disable spell checking
vim.keymap.set('n', '<Leader>se', ':setlocal spell spelllang=en_us<CR>')
vim.keymap.set('n', '<Leader>sn', ':setlocal nospell<CR>')

-- Unhighlight search
vim.keymap.set('n', '<C-l>', ':nohl<CR><C-l>', { silent = true })

-- Mappings for ToggleComment plugin
vim.keymap.set('n', ',#', ':call CommentLineToEnd("# ")<CR>+', { silent = true })
vim.keymap.set('n', ';#', ':call CommentLineToEnd("### ")<CR>+', { silent = true })
vim.keymap.set('n', ',/', ':call CommentLineToEnd("// ")<CR>+', { silent = true })
vim.keymap.set('n', ',"', ':call CommentLineToEnd("\\" ")<CR>+', { silent = true })
vim.keymap.set('n', ',;', ':call CommentLineToEnd("; ")<CR>+', { silent = true })
vim.keymap.set('n', ',-', ':call CommentLineToEnd("-- ")<CR>+', { silent = true })
vim.keymap.set('n', ',*', ':call CommentLinePincer("/* ", " */")<CR>+', { silent = true })
vim.keymap.set('n', ',<', ':call CommentLinePincer("<!-- ", " -->")<CR>+', { silent = true })

-- Mappings for taglist plugin
vim.keymap.set('n', 'tt', ':TlistToggle<CR>', { silent = true })

-- Mappings for tabs
vim.keymap.set('n', '<C-w>t', ':tabnew<CR>', { silent = true })
vim.keymap.set('n', 'tn', ':tabnext<CR>', { silent = true })
vim.keymap.set('n', 'tp', ':tabprevious<CR>', { silent = true })

-- Mappings for p4 commands. See ~/.vim/plugin/Santhosh.vim
vim.keymap.set('n', '<Leader>pe', ':call P4Edit()<CR>')
vim.keymap.set('n', '<Leader>pr', ':call P4Revert()<CR>')
vim.keymap.set('n', '<Leader>po', ':call P4Opened()<CR>')

-- Map Ctrl+x to :write (save the file)
vim.keymap.set('n', '<C-x>', ':update<CR>', { silent = true })
vim.keymap.set('i', '<C-x>', '<C-O>:update<CR><Esc>', { silent = true })
vim.keymap.set('v', '<C-x>', '<C-C>:update<CR>', { silent = true })

-- Map \b to show buffers
vim.keymap.set('n', '<Leader>b', ':buffers<CR>')

-- Map \m to show marks
vim.keymap.set('n', '<Leader>m', ':marks<CR>')

-- Map Ctrl + Shift + H to show the hightlight group of word under the cursor
vim.keymap.set('n', '<C-S-H>', ':call ShowHighlightGroup()<CR>')

-- Key mappings for fugitive git plugin
vim.keymap.set('n', '<Leader>gs', ':Gstatus<CR>')
vim.keymap.set('n', '<Leader>gb', ':Gblame<CR>')
vim.keymap.set('n', '<Leader>gw', ':Gwrite<CR>')
vim.keymap.set('n', '<Leader>gc', ':Gcommit<CR>')
vim.keymap.set('n', '<Leader>gl', ':Glog<CR>')
vim.keymap.set('n', '<Leader>gd', ':Gdiff<CR>')

-- Auto Commands
local augroup = vim.api.nvim_create_augroup('SanthoshConfig', { clear = true })

-- Cleanup fugitive buffers
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup,
  pattern = 'fugitive://*',
  command = 'set bufhidden=delete'
})

-- Set filetype on opening a file
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  group = augroup,
  pattern = '*.h',
  command = 'set filetype=c'
})

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  group = augroup,
  pattern = '*.pm',
  command = 'set filetype=perl'
})

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  group = augroup,
  pattern = {'*.mk', '*.make'},
  command = 'set filetype=make'
})

-- Set file formatting when opening a .c or .h file
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  group = augroup,
  pattern = {'*.c', '*.h'},
  command = 'call SetFormatting()'
})

-- Don't allow modifications to readonly and log files
vim.api.nvim_create_autocmd('BufEnter', {
  group = augroup,
  pattern = '*',
  command = 'if &readonly | setl nomodifiable | endif'
})
-- vim.api.nvim_create_autocmd('BufEnter', {
--   group = augroup,
--   pattern = '*.log',
--   command = 'setl readonly nomodifiable'
-- })

-- Don't expand tab to spaces in make and config files
-- vim.api.nvim_create_autocmd('FileType', {
--   group = augroup,
--   pattern = {'make', 'conf'},
--   command = 'setlocal noexpandtab nosmarttab'
-- })
vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = 'make',
  command = 'setlocal noexpandtab nosmarttab'
})

-- Jump to last known cursor position (if valid) on file open.
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup,
  pattern = '*',
  callback = function()
    local line = vim.fn.line("'\"")
    if line > 0 and line <= vim.fn.line("$") then
      vim.cmd('normal! g`"')
    end
  end
})

-- Auto cmds specific to ToggleComment plugin
vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = 'perl',
  callback = function()
    vim.keymap.set('n', '<C-c>', ':call CommentLineToEnd("# ")<CR>+', { buffer = true, silent = true })
  end
})

vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = 'c',
  callback = function()
    vim.keymap.set('n', '<C-c>', ':call CommentLinePincer("/* ", " */")<CR>+', { buffer = true, silent = true })
  end
})

vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = 'cpp',
  callback = function()
    vim.keymap.set('n', '<C-c>', ':call CommentLinePincer("/* ", " */")<CR>+', { buffer = true, silent = true })
  end
})

-- This will map \-c to put a #if 0/#endif above and below the selected lines
vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = 'c',
  command = 'call SetCommentKeyMappingForC()'
})

-- Autoload cscope db from any of the parent folders
-- vim.api.nvim_create_autocmd('BufEnter', {
--   group = augroup,
--   pattern = '/*',
--   command = 'call LoadCscope()'
-- })
-- vim.api.nvim_create_autocmd('VimEnter', {
--   group = augroup,
--   command = 'call LoadCscope()'
-- })

-- Abbreviations
-- Abbreviations for cscope (in same window)
vim.cmd([[
cnoreabbrev csg cs f g
cnoreabbrev css cs f s
cnoreabbrev csc cs f c
cnoreabbrev csf cs f f
cnoreabbrev cse cs f e
cnoreabbrev cst cs f t

" Abbreviations for cscope (in vertical split window)
cnoreabbrev vcsg vert scs f g
cnoreabbrev vcss vert scs f s
cnoreabbrev vcsc vert scs f c
cnoreabbrev vcsf vert scs f f

" Abbreviations for cscope (in horizontal split window)
cnoreabbrev hcsg scs f g
cnoreabbrev hcss scs f s
cnoreabbrev hcsc scs f c
cnoreabbrev hcsf scs f f
]])

-- Set cursor shape depending on mode
vim.cmd([[
if exists('$TERM') && &term =~ 'xterm'
  set ttimeout
  set ttimeoutlen=100
  let &t_SI = "\e[6 q"   " Insert mode: vertical bar
  let &t_EI = "\e[2 q"   " Normal/other modes: block
endif
]])
