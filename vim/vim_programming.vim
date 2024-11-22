"---TERMINAL SETTINGS---
set shell=zsh

function! TermStart(layout, shellcmd)     "Starts terminal with layout and shell command.
  let layout = a:layout == 0 ? "": a:layout < 5 ? "vert ": "tab "

  if len(a:shellcmd) == 0     "Run shell without command.
    let terms = term_list()
    let opens = filter(copy(terms), "len( win_findbuf(v:val) ) > 0")
    let tercmd = len(terms) == 0 ? "ter": "sb ".(len(opens) == 0 ? terms[0]: opens[0])
    exe layout."bot ".tercmd
  else                        "Run command, bash -c and quotes for chained commands.
    exe layout."bot ter ++close bash -c \"".a:shellcmd."; echo -n '-END-'; read line\""
  endif
endfunction

nnoremap <silent><leader>t :<C-u>call TermStart(v:count, "")<CR>
"Map escape in terminal can alter some keys having escape sequences.
tnoremap <ESC> <C-\><C-n>

"BufWinEnter for hidden display on same window, WinEnter for switch window.
autocmd BufWinEnter,WinEnter * if &buftype ==# "terminal" | exe "silent! normal i" | setlocal nobl | endif
"Setup in terminal event to due with start terminal by 'ter' command.
autocmd TerminalWinOpen * setlocal nobuflisted

"--dBUILD, RUN SETTINGS---
let $PATH .= has("win32") ? ";.": ":."  "Add current dir to PATH for convenience.
set makeprg=.build

"Avoid to build and jump to errors on unlisted buffer.
"make jumps to error after build but causes screen mess, so use make! and cc.
nnoremap <silent><expr><leader>b &buflisted ? ":silent! wa<CR>:make!<CR><CR>:cc<CR>": ""
imap <leader>b <Esc><leader>b

nnoremap <silent><C-Up> :silent! cp<BAR>cc<CR>
nnoremap <silent><C-Down> :silent! cn<BAR>cc<CR>

"Avoid to open terminal and run on unlisted buffer.
nnoremap <silent><expr><leader>r &buflisted ? ":<C-u>let vc=v:count<CR>:silent! wa<CR>:call TermStart(vc, '.run')<CR>": ""
imap <leader>r <Esc><leader>r
tnoremap <leader>r <C-u>.run<Cr>

"---DEBUG SETTINGS---
"In MS-Windows, update termdebug.vim:GetFullname function with the following:
"  if has('win32') && name =~ "\t"
"    " In MS-Windows, path containing '..\\t..' will be changed
"    " to tab character "\t" by DecodeMessage function,
"    " so change back tab character "\t" to '\\t'.
"    let name = substitute(name, "\t", '\\t', 'g')
"  endif
packadd termdebug
let g:termdebug_wide = 1            "Set to non-zero to split debug windows vertically.

function! OpenDebugger()
  if !exists("g:debug")             "Debug does not exist, start new one.
    let arg = filereadable(".debug") ? readfile(".debug")[0]: ""
    exec "silent Termdebug ".arg | wincmd p
  else | exe "sb ".g:debug | endif  "Debug exists, focus to it.
endfunction

nmap <silent><leader>d :call OpenDebugger()<CR>

nmap <silent><expr>b !exists("g:debug") ? "b": ":<C-u>Break<CR>"
nmap <silent><expr>r !exists("g:debug") ? "r": ":<C-u>Run<CR>"
nmap <silent><expr>c !exists("g:debug") ? "c": ":<C-u>Continue<CR>"
nmap <silent><expr>n !exists("g:debug") ? "n": ":<C-u>Over<CR>"
nmap <silent><expr>s !exists("g:debug") ? "s": ":<C-u>Step<CR>"
nmap <silent><expr>f !exists("g:debug") ? "f": ":<C-u>Finish<CR>"
nmap <silent><expr>u !exists("g:debug") ? "u": ":call TermDebugSendCommand('disable')<CR>".
                                             \ ":call TermDebugSendCommand('until " . line('.') . "')<CR>".
                                             \ ":call TermDebugSendCommand('enable')<CR>"
nmap <silent><expr>d !exists("g:debug") ? "d": ":call TermDebugSendCommand('clear " . expand('%') . ":" . line('.') . "')<CR>"
nmap <silent><expr>q !exists("g:debug") ? "q": ":call TermDebugSendCommand('q')<CR>"

"Pre-start: turn off mouse to disable debug toolbar.
autocmd User TermdebugStartPre setlocal mouse=
"Post-start: set up debug windows and GDB.
autocmd User TermdebugStartPost
  \ let g:debug = bufnr() | setlocal nobl nonu nornu mouse=a | vert res 35
  \ | if has("linux") | wincmd c | endif
  \ | call TermDebugSendCommand("set confirm off")
  \ | call TermDebugSendCommand("source .break")
  \ | call TermDebugSendCommand("define hook-quit")
    \ | call TermDebugSendCommand("shell rm -f .break")
    \ | call TermDebugSendCommand("save breakpoints .break")
  \ | call TermDebugSendCommand("end")
"Post-stop: clean up debug.
autocmd User TermdebugStopPost unlet g:debug
