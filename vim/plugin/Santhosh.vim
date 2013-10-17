""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autoload cscope db                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction

call LoadCscope()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Re-build and reload cscope db                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ReloadCscope()
   let l:bora = matchstr(getcwd(), '.*bora')
   if !empty(l:bora)
      echo "Wait while rebuilding cscope for " . l:bora . "..."
      call system("build-cscope -d " . l:bora)
      exe "silent cs reset"
      redraw
      echo "Reloaded cscope"
   else
      echo "Not in bora directory"
   endif
endfunction



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PrintError                                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function PrintError(msg)
      echohl ErrorMsg
      echo a:msg
      echohl None
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ToggleRightMarginHi                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function ToggleRightMarginHi()
   if exists("b:right_margin_hi_on") && b:right_margin_hi_on == 1
      highlight clear right_margin
      let b:right_margin_hi_on = 0
      echo "Right margin highlight turned off"
   else
      highlight right_margin term=NONE ctermbg=235 ctermfg=15
      match right_margin '\%>80v.\+'
      let b:right_margin_hi_on = 1
      echo "Right margin highlight turned on"
   endif
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EditAndSetMode                                         "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function EditAndSetMode()
   edit
   if &readonly
      setl nomodifiable
   else
      set modifiable
   endif
   redraw
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" P4Edit                                                 "
"  p4 edit the current file. Also, reloads the file      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function P4Edit()
   call system("p4 edit " . expand("%"))
   if v:shell_error != 0
      call PrintError("Failed to p4 edit " . expand("%"))
   else
      call EditAndSetMode()
      echo expand("%") . " opened for edit."
   endif
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" P4Revert                                               "
"  p4 revert the current file. Also, reloads the file    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function P4Revert()
   call system("p4 revert " . expand("%"))
   if v:shell_error != 0
      call PrintError("Failed to p4 revert " . expand("%"))
   else
      call EditAndSetMode()
      echo expand("%") . " reverted."
   endif
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" P4Opened                                               "
"  Show a list of p4 opened files                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function P4Opened()
   let l:opened = system("p4 opened")
   if v:shell_error != 0
      call PrintError("\"p4 opened\" failed.")
   else
      call EditAndSetMode()
      echo "P4 Opened files\n===============\n" . l:opened
   endif
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SetFormatting                                          "
"  Set formatting options based on the current file      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function SetFormatting()
   let l:bsd_path3 = matchstr(expand("%:p"), 'modules\/vmkernel\/tcpip3\/freebsd')
   let l:bsd_path4 = matchstr(expand("%:p"), 'modules\/vmkernel\/tcpip4\/freebsd')
   let l:ovs_esx_kernel_path = matchstr(expand("%:p"), 'ovs-on-esx\/nsx-int.*\/esx\/kernel')
   let l:ovs_path = matchstr(expand("%:p"), 'ovs-on-esx\/nsx-int')
   if !empty(l:bsd_path3) || !empty(l:bsd_path4)
      " FreeBSD code
      set tabstop=8 shiftwidth=8 noexpandtab
   elseif !empty(l:ovs_esx_kernel_path)
      " OVS esx kernel code
      set tabstop=3 shiftwidth=3 expandtab
   elseif !empty(l:ovs_path)
      " OVS code
      set tabstop=4 shiftwidth=4 expandtab
   else
      " Defaulting to VMkernel coding standard for 
      " everything else.
      set tabstop=3 shiftwidth=3 expandtab
   endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ShowHighlightGroup                                     "
"  Show the syntax/highlight group that the word under   "
"  the cursor belongs to.                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function ShowHighlightGroup()
   if !exists("*synstack")
      return
   endif
   echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
