"---BASIC SETTINGS---
filetype plugin indent on
syntax on

set backspace=2 laststatus=2  "Normal backspace, always show status line.
set mouse=a nowrap number     "Mouse in all modes, do not wrap line.
set tabstop=2 softtabstop=2   "Tab width (hard/soft).
set shiftwidth=2 expandtab    "Indent width, replace tab with spaces.
set incsearch nohls showcmd   "Show first match when typing search.
set ignorecase smartcase      "Search case-sensitive with upper-case chars.
set wildmenu wildcharm=<TAB>  "Enable command-line completion with <TAB>.
set wildignorecase            "Case-insensitive completion.
set wildoptions=pum           "Use vertical completion menu.
set wildmode=full:longest     "Show matches but not select the first.
set hidden confirm            "Allow hiding buffer, ask confirm for save.
set switchbuf=useopen,usetab  "Use already opened buffer when switching.
set splitbelow splitright     "Split window below and right.
set fileformats=unix,dos,mac  "Due with different End-Of-Line char.
set visualbell t_vb=          "Disable error bell.
set timeoutlen=500            "Mapping delay.
set ttimeoutlen=10            "Key code delay, affect terminal escape.
set background=dark

if has("gui_running")         "GVIM SECTION:
  let &guifont = has("win32") ? "consolas:h16": "roboto\ mono\ 15"
	set guioptions-=m guioptions-=T guioptions-=L   "Hide menubar, toolbar, left scrollbar.
endif

"STATUS SECTION: Filename [Modified]Filetype]      Col,Row/Total-line   Percentage.
set statusline=%f\ %<%m%y%=%-14.(%v,%l/%L%)\ %P

"CURSOR SECTION:
if (has("gui_running")) | set guicursor+=n-v-c:blinkon0 "Disable blinking in n-v-c mode.
else
	autocmd InsertEnter * silent !echo -ne "\e[5 q"
	autocmd InsertLeave,VimEnter * silent !echo -ne "\e[2 q"
endif

autocmd InsertEnter * silent! set cul   "Toggle cursor line normal/insert mode.
autocmd InsertLeave * silent! set nocul

autocmd BufEnter,WinEnter * silent! if &nu | set rnu | endif  "Toggle relative line number.
autocmd WinLeave * silent! if &nu | set nornu | endif

let mapleader=","

"---EDITING SETTINGS---
"Save all: silent! to skip nofile-save error.
nnoremap <silent><leader>s :silent! wa<CR>
imap <leader>s <Esc><leader>s

"Quit all: qa! to cancel nofile-save and terminal-kill confirm.
nnoremap <leader>q :silent! wa<CR>:qa!<CR>
tmap <leader>q <C-\><C-n><leader>q

"Select all.
nnoremap <leader>a gg0VG

"Toggle background.
nnoremap <expr><leader>g &bg == 'dark' ? ":set bg=light<CR>": ":set bg=dark<CR>"

"Replace word/selection.
nnoremap <leader>h :%s/<C-r>=expand("<cword>")<Cr>//gc<Left><Left><Left>
vnoremap <leader>h y:%s/<C-r>0//gc<Left><Left><Left>

"Calculate expression.
vnoremap <leader>= c<Esc>pa<SPACE>=<SPACE><C-r>=<C-r>"<CR>

"Insert line(s).
nnoremap <Ins> I<CR><Up><Esc>
nnoremap o @='<C-v><Esc>o'<CR>
nnoremap O @='<C-v><Esc>O'<CR>

"Move selection line(s).
vnoremap <S-Up> :<C-u>silent! '<,'>m-2<CR>gv
vnoremap <S-Down> :<C-u>silent! '<,'>m'>+1<CR>gv

"---WINDOW AND BUFFER SETTINGS---
inoremap <C-w> <C-o><C-w>
"List buffers.
nnoremap <leader><Tab> :ls<CR>:b<space>
"Wipe all buffers: silent! to skip nofile-save error, wipe! to cancel it.
nnoremap <silent><leader>C :silent! wa<BAR>%bw!<CR>

"---FILE BROWSING SETTINGS---
"Search path: current file path (.), current path(,), 1-level sub paths.
set path=.,,*
set wildignore=*.swp,*.o,*.obj
nnoremap <S-Tab> :fin<Space>

source ~/vim_programming.vim
source ~/vim_plugins.vim
" source ~/vim_chat.vim
