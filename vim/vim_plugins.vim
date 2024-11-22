"---VIM-PLUG SETTINGS---
let plugPath = has("win32") ? "/vimfiles" : "/.vim"
if (!filereadable($HOME.plugPath."/autoload/plug.vim"))
  echo "Vim-Plug is not installed, no plug-in is loaded." | finish
endif

call plug#begin()
  Plug 'morhetz/gruvbox'                          "Color scheme.
  Plug 'preservim/nerdtree'                       "File listing.
  Plug 'neoclide/coc.nvim', {'branch': 'release'} "Code completion.
  Plug 'omnisharp/omnisharp-vim'                  "Code completion.
call plug#end()

"---COLOR SETTINGS---
function! Highlight()
  if g:colors_name =~ 'gruvbox'
    if &background == 'dark'
      hi! GruvboxRed guifg=#ea6962
      hi! GruvboxBlue guifg=#87afaf
    endif

    hi! link Function GruvboxBlue
  endif

  if &background == 'dark'
    hi! Normal ctermbg=234 guibg=#1d2021 guifg=#ffd7af
    hi! default debugPC term=reverse ctermbg=darkblue guibg=darkblue
    hi! default debugBreakpoint term=reverse ctermbg=red guibg=red
  else
    hi! Normal guibg=#fffafa
    hi! CocMenuSel ctermbg=231 guibg=#ffffff
    hi! default debugPC term=reverse ctermbg=lightblue guibg=lightblue
    hi! default debugBreakpoint term=reverse ctermbg=lightred guibg=lightred
  endif

  hi! link cStructure Statement
  hi! link cppStructure Statement
  hi! link CocSemClass Type
  hi! link CocSemFunction Function
  hi! link CocSemMethod Function
  hi! link CocSemProperty Function
  hi! link CocSemVariable Normal
  hi! link CocSemParameter Normal
endfunction

"GRUVBOX:
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'hard'
let g:gruvbox_invert_selection = 0
let g:gruvbox_bold = 0

"OMNISHARP-VIM:
let g:OmniSharp_highlight_groups = {'ParameterName': 'Normal',  'LocalName': 'Normal', 'FieldName': 'Normal'}

autocmd colorscheme * silent! call Highlight()
silent! colorscheme gruvbox

"---FILE LISTING SETTINGS---
let NERDTreeWinSize = 20
let NERDTreeQuitOnOpen = 1

"Start Vim with directory argument.
autocmd VimEnter * silent! if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') | exec 'cd ' . argv()[0] | enew | endif

"Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | q | endif

"Change NERDTree current directory based on VIM current directory.
autocmd DirChanged global exec 'NERDTreeCWD | NERDTreeClose'

"Toggle NERDTree.
nnoremap <expr><silent><leader>f exists('b:NERDTree') ? ":NERDTreeClose<CR>" : ":NERDTreeFocus<BAR>silent! NERDTreeRefreshRoot<CR>"
imap <leader>f <Esc><leader>f
tmap <leader>f <C-\><C-n><leader>f

"---CODE COMPLETION SETTINGS---
let g:coc_global_extensions = ['coc-tsserver', 'coc-clangd', 'coc-cmake', 'coc-pairs', 'coc-python']
let g:coc_disable_startup_warning = 1

"Make <CR> auto-select the first completion item and format on enter.
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"Symbol rename, navigate diagnostics (:CocDiagnostics to list all).
nmap <C-h> <Plug>(coc-rename)
nmap <silent><M-Up> <Plug>(coc-diagnostic-prev)
nmap <silent><M-Down> <Plug>(coc-diagnostic-next)

"GoTo code navigation.
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gi <Plug>(coc-implementation)
