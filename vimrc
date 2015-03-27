"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            Santhosh's VIM config                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""
"      Pathogen Plugin Settings           "
"""""""""""""""""""""""""""""""""""""""""""
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

"""""""""""""""""""""""""""""""""""""""""""
"          General Settings               "
"""""""""""""""""""""""""""""""""""""""""""
set autoindent                   " Always set autoindenting on
set backspace=indent,eol,start   " Backspace over everything in insert mode
set cinoptions=g0,t0,c1s,(0,m1,l1 " C indent options. See :help cinoptions-values
set cinwords+=case               " C indent keywords
set cursorline                   " Highlight cursorline
set esckeys                      " Recognize fn keys starting with Esc in insert mode
set expandtab                    " Replace <tab> with tabstop spaces in insert mode
set formatoptions=2ntcroqlv      " Auto formatting. See :help fo-table
set hidden                       " Keep unchanged
set history=100                  " Keep 100 lines of command line history
set hlsearch                     " Highlight search matches
set incsearch                    " Display matches while typing pattern
set laststatus=2                 " Always display status line
set magic                        " Interpret special characters in pattern matching
set nobackup                     " Do not keep a backup file
set nocompatible                 " Use vim mode and not vi compatibility mode
                                 " Note: Always have this at the very beginning
                                 " of the file as the first config line.
set noerrorbells                 " Don't beep on errors
set nostartofline                " Don't jump to start of line during page up/down
set nowrapscan                   " Don't wrap searches around end of file
set pastetoggle=<F2>             " Set F2 as paste toggle key
set ruler                        " Always show cursor position in statusbar
set scrolloff=2                  " Always show 2 lines above and below the cursor
set shiftwidth=3                 " Num spaces to use for each indent
set showcmd                      " Display incomplete commands in the last line
set showmatch                    " Show matching braces
set showmode                     " Show current mode in status line
set smarttab                     " Insert tab based on shiftwidth, at line beginning
set splitright                   " Show the cscope search result on the right
                                 " for vertical splits
set t_Co=256                     " Enable 256 color support
set tabstop=3                    " Set tab to 3 spaces
set textwidth=79                 " Break lines longer than 79 chars
set visualbell t_vb=             " Don't flash screen on errors
set whichwrap=b,s,h,l,<,>,[,]    " Wrap cursor to move next/prev lines when at end/beginning of a line
set wildmenu                     " Enhanced command line completion
set writebackup                  " Backup before overwriting, delete after writing

colorscheme ron_custom           " Set the color scheme
filetype indent on               " Intelligent auto-indent based on filetype
filetype plugin on               " Enable filetype plugin. For CCTree.vim
fixdel                           " Fix Del key behavior
syntax on                        " Turn syntax coloring on


"""""""""""""""""""""""""""""""""""""""""""
"          Status Line                    "
"""""""""""""""""""""""""""""""""""""""""""
" Format used:
" <truncate at beginning><file-path> <help><modified><readonly> <git branch> " <<Right indent>> <line#/total-lines,col#/virt col#>, <current pos in file>
set statusline=%<%f\ %h%m%r\ %{fugitive#statusline()}\ %=%-14.(%l/%L,%c%V%)\ %P


"""""""""""""""""""""""""""""""""""""""""""
"          Global variables               "
"""""""""""""""""""""""""""""""""""""""""""
let c_comment_strings=1          " Highlight strings and number inside C comment
let c_space_errors=1             " Highlight unwanted spaces

" Options for TList Toggle
let Tlist_Exit_OnlyWindow = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Auto_Highlight_Tag = 1
let Tlist_WinWidth = 35
let Tlist_GainFocus_On_ToggleOpen = 1

" Options for showmarks plugin
let g:showmarks_enable = 0
let g:showmarks_textlower=">"
let g:showmarks_textupper=">"


"""""""""""""""""""""""""""""""""""""""""""
"          Highlight Groups               "
"""""""""""""""""""""""""""""""""""""""""""
" Colors for showmarks plugin
highlight default ShowMarksHLl ctermfg=0 ctermbg=250 cterm=bold
highlight default ShowMarksHLu ctermfg=0 ctermbg=250 cterm=bold
highlight default ShowMarksHLo ctermfg=0 ctermbg=250 cterm=bold
highlight default ShowMarksHLm ctermfg=0 ctermbg=250 cterm=bold

" Highlight trailing white spaces
hi tws term=NONE cterm=NONE ctermbg=1 ctermfg=1
match tws /\s\+$/


"""""""""""""""""""""""""""""""""""""""""""
"          Key Mappings                   "
"""""""""""""""""""""""""""""""""""""""""""
" Set paste toggle
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O><F2>

nnoremap <F3> :call ToggleRightMarginHi()<CR>
nnoremap <F4> :call ReloadCscope()<CR>

" Key binding for ShowMarks plugin
nnoremap <F6> :ShowMarksToggle<CR>

" Enable/Disable spell checking
map <Leader>se :setlocal spell spelllang=en_us<CR>
map <Leader>sn :setlocal nospell<CR>

" Unhighlight search
noremap <silent> <C-l> :nohl<CR><C-l>

" Mappings for ToggleComment plugin
noremap <silent> ,# :call CommentLineToEnd('# ')<CR>+
noremap <silent> ;# :call CommentLineToEnd('### ')<CR>+
noremap <silent> ,/ :call CommentLineToEnd('// ')<CR>+
noremap <silent> ," :call CommentLineToEnd('" ')<CR>+
noremap <silent> ,; :call CommentLineToEnd('; ')<CR>+
noremap <silent> ,- :call CommentLineToEnd('-- ')<CR>+
noremap <silent> ,* :call CommentLinePincer('/* ', ' */')<CR>+
noremap <silent> ,< :call CommentLinePincer('<!-- ', ' -->')<CR>+

" Mappings for taglist plugin
noremap <silent> tt :TlistToggle<CR>

" Mappings for tabs
noremap <silent> <C-w>t :tabnew<CR>
noremap <silent> tn :tabnext<CR>
noremap <silent> tp :tabprevious<CR>

" Mappings for p4 commands. See ~/.vim/plugin/Santhosh.vim
noremap <Leader>pe :call P4Edit()<CR>
noremap <Leader>pr :call P4Revert()<CR>
noremap <Leader>po :call P4Opened()<CR>

" Map Ctrl+x to :write (save the file)
noremap <silent> <C-x> :update<CR>
inoremap <silent> <C-x> <C-O>:update<CR><Esc>
vnoremap <silent> <C-x> <C-C>:update<CR>

" Map \b to show buffers
noremap <Leader>b :buffers<CR>

" Map \m to show marks
noremap <Leader>m :marks<CR>

" Map Ctrl + Shift + H to show the hightlight group
" of word under the cursor
noremap <C-S-H> :call ShowHighlightGroup()<CR>

" Key mappings for fugitive git plugin
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gw :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gl :Glog<CR>
noremap <Leader>gd :Gdiff<CR>


"""""""""""""""""""""""""""""""""""""""""""
"          Auto Commands                  "
"""""""""""""""""""""""""""""""""""""""""""

" Cleanup fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

" Set filetype on opening a file
autocmd BufNewFile,BufRead *.h set filetype=c
autocmd BufNewFile,BufRead *.pm set filetype=perl
autocmd BufNewFile,BufRead *.mk,*.make set filetype=make

" Set file formatting when opening a .c or .h file
autocmd BufNewFile,BufRead *.c,*.h  call SetFormatting()

" Don't allow modifications to readonly and log files
autocmd BufEnter * if &readonly | setl nomodifiable | endif
autocmd BufEnter *.log setl readonly nomodifiable

" Don't expand tab to spaces in make and config files
autocmd FileType make,conf setlocal noexpandtab nosmarttab

" Jump to last known cursor position (if valid) on file open.
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" Auto cmds specific to ToggleComment plugin
autocmd FileType perl noremap <silent> <buffer> <C-c> :call CommentLineToEnd('# ')<CR>+
autocmd FileType c noremap <silent> <buffer> <C-c> :call CommentLinePincer('/* ', ' */')<CR>+
autocmd FileType cpp noremap <silent> <buffer> <C-c> :call CommentLinePincer('/* ', ' */')<CR>+

" This will map \-c to put a #if 0/#endif above and below the selected lines
autocmd FileType c call SetCommentKeyMappingForC()


" Autoload cscope db from any of the parent folders
" autocmd BufEnter /* call LoadCscope()
" autocmd VimEnter * call LoadCscope()


"""""""""""""""""""""""""""""""""""""""""""
"          Abbrevations                   "
"""""""""""""""""""""""""""""""""""""""""""

" Abbrevations for cscope (in same window)
cnoreabbrev csg cs f g
cnoreabbrev css cs f s
cnoreabbrev csc cs f c
cnoreabbrev csf cs f f
cnoreabbrev cse cs f e
cnoreabbrev cst cs f t

" Abbrevations for cscope (in vertical split window)
cnoreabbrev vcsg vert scs f g
cnoreabbrev vcss vert scs f s
cnoreabbrev vcsc vert scs f c
cnoreabbrev vcsf vert scs f f

" Abbrevations for cscope (in horizontal split window)
cnoreabbrev hcsg scs f g
cnoreabbrev hcss scs f s
cnoreabbrev hcsc scs f c
cnoreabbrev hcsf scs f f
