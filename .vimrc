""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
"	Aleksa Markovic
"
" Sections:
"	General
"	Commands
"	Mappings
"	Syntax_and_colors
"	Lua

""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""
" General:

set ruler
set history=500
set cmdheight=1
set backspace=indent,eol,start
set tabstop=8 shiftwidth=8
set hlsearch

set complete+=i
set complete+=k

set nobackup
set nowb
set noswapfile

""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""
" Commands:

command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
autocmd BufWritePre * %s/\s\+$//e
set include=^\s*#\s*include
autocmd FileType lua set includeexpr=substitute(v:fname,'\\(.*\\)','\\1.lua','')
autocmd FileType lua setlocal include=^\s*require

""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""

function! CallIt()
    execute "!echo " . getline("'<")[getpos("'<")[2]-1:getpos("'>")[2]]
endfunction

" Mappings:
map <C-c> :!typos %<CR>
map <C-R> :!typos -w %<CR>L<CR>
map <C-T> :call CallIt()<CR>

""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""
" Syntax_and_colors:

syntax on
colorscheme default
hi Search cterm=NONE ctermfg=white ctermbg=blue
set ffs=unix

""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""
" Lua:
luafile ~/.vim/lua/helper.lua
luafile ~/.vim/lua/vimComplete.lua

lua vimComplete.setPath(vim)

command -nargs=+ MkFun lua vimComplete.makeFun(vim.buffer(), vim.window().line, "<args>")
command -nargs=+ MkLoop lua vimComplete.makeLoop(vim.buffer(), vim.window().line, "<args>")
command -nargs=+ MkIf lua vimComplete.makeIfStatement(vim.buffer(), vim.window().line, "<args>")

imap <C-f> <Esc> :MkFun <C-R><C-A><CR>dd<CR> i
imap <C-l> <Esc> :MkLoop <C-R><C-A><CR>dd<CR> i
imap <C-s> <Esc> :MkIf <C-R><C-A><CR>dd<CR> i

map <C-f> <Esc> :MkFun <C-R><C-A><CR>dd<CR>
map <C-l> <Esc> :MkLoop <C-R><C-A><CR>dd<CR>
map <C-s> <Esc> :MkIf <C-R><C-A><CR>dd<CR>

""""""""""""""""""""""""""""""""""""""""""""
