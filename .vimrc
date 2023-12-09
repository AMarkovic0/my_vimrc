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
set ffs=unix
set hlsearch
set laststatus=2
set statusline+=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

set complete+=i
set complete+=k

set nobackup
set nowb
set noswapfile

""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""
" Syntax_and_colors:

syntax on
colorscheme default
hi Search cterm=NONE ctermfg=white ctermbg=blue

""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""
" Commands:

autocmd BufWritePre * %s/\s\+$//e
autocmd FileType lua set includeexpr=substitute(v:fname,'\\(.*\\)','\\1.lua','')
autocmd FileType lua setlocal include=^\s*require
autocmd FileType c,cpp,h,hpp setlocal include=^\s*#\s*include

function! PackCode(code_lines)
    shellescape(join(a:code_lines, "\\\n\r"))
endfunction

function! GetVisualSelection()
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)

    if len(lines) == 0
        return ''
    endif

    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive') ? 1 : 2)]
    let lines[0] = lines[0] = lines[0][column_start - 1:]

    return PackCode(lines)
endfunction

function! GetWholeFile()
    let line_start = 1
    let line_end = line('$')
    let lines = getline(line_start, line_end)

    if len(lines) == 0
        return ''
    endif

    return PackCode(lines)
endfunction

command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
command SpellC setlocal spell spelllang=en_us
command -nargs=1 SLua vim "<args>" **/*.lua
command -nargs=1 Sc vim "<args>" **/*.c*
command -nargs=1 Sh vim "<args>" **/*.h*
command -nargs=1 Exec new | r ! "<args>"

""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""
" Mappings:

function! CallIt()
    execute "!echo " . getline("'<")[getpos("'<")[2]-1:getpos("'>")[2]]
endfunction

map <C-c> :!typos %<CR>
map <C-R> :!typos -w %<CR>L<CR>
map <C-T> :call CallIt()<CR>

""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""
" Lua:

"luafile ~/.vim/lua/helper.lua
"luafile ~/.vim/lua/vimComplete.lua
"
"lua vimComplete.setPath(vim)
"
"command -nargs=+ MkFun lua vimComplete.makeFun(vim.buffer(), vim.window().line, "<args>")
"command -nargs=+ MkLoop lua vimComplete.makeLoop(vim.buffer(), vim.window().line, "<args>")
"command -nargs=+ MkIf lua vimComplete.makeIfStatement(vim.buffer(), vim.window().line, "<args>")
"
"imap <C-f> <Esc> :MkFun <C-R><C-A><CR>dd<CR> i
"imap <C-l> <Esc> :MkLoop <C-R><C-A><CR>dd<CR> i
"imap <C-s> <Esc> :MkIf <C-R><C-A><CR>dd<CR> i
"
"map <C-f> <Esc> :MkFun <C-R><C-A><CR>dd<CR>
"map <C-l> <Esc> :MkLoop <C-R><C-A><CR>dd<CR>
"map <C-s> <Esc> :MkIf <C-R><C-A><CR>dd<CR>

""""""""""""""""""""""""""""""""""""""""""""
