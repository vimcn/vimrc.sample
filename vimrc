" Vim 标准配置方案。

if has("win32") || has("win32unix")
    let g:OS#name = "win"
    let g:OS#win = 1
    let g:OS#mac = 0
    let g:OS#unix = 0
elseif has("mac")
    let g:OS#name = "mac"
    let g:OS#mac = 1
    let g:OS#win = 0
    let g:OS#unix = 0
elseif has("unix")
    let g:OS#name = "unix"
    let g:OS#unix = 1
    let g:OS#win = 0
    let g:OS#mac = 0
endif
if has("gui_running")
    let g:OS#gui = 1
else
    let g:OS#gui = 0
endif

set nocompatible
if g:OS#win
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin
endif

filetype plugin on
filetype indent on
syntax on
filetype on

" 编码设置
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set langmenu=zh_CN.utf-8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
language messages zh_CN.UTF-8

" 文件格式，默认 ffs=dos,unix
set fileformat=unix
set fileformats=unix,dos,mac

" 设置窗口默认大小。
set columns=90
set lines=30

" 字体设置
" @see http://support.microsoft.com/kb/306527/zh-cn
" @see http://www.gracecode.com/archives/1545/
" @see http://blog.xianyun.org/2009/09/14/vim-fonts.html
if g:OS#win
    set guifont=Courier_New:h12:cANSI
elseif g:OS#mac
    set guifont=Courier_New:h16
elseif g:OS#unix
endif

" 交换文件(swrap file)，自动备份(auto backup)设置。
set nobackup
if g:OS#win
    set directory=$VIM\tmp
else
    set directory=~/.tmp
endif

" 持久化撤销设置。
if has("persistent_undo")
    set undofile
    set undolevels=1000

    if g:OS#win
        set undodir=$VIM\undodir
        au BufWritePre undodir/* setlocal noundofile
    else
        set undodir=~/.undodir
        au BufWritePre ~/.undodir/* setlocal noundofile
    endif
endif

" Tabs
set softtabstop=4
set expandtab       " replace tab to whitespace.
set tabstop=4       " show tab indent word space.
set shiftwidth=4    " tab length


set linebreak       " break full word.
set autoindent      " new line indent same this line.
set smartindent

set splitright
"set splitbelow

" 设置设置。
set foldmethod=syntax
set foldlevel=6
set foldcolumn=0

set ignorecase
set smartcase
set number          " 显示行号。

" fixed.
set scrolloff=3

" 切换显示/隐藏菜单栏、工具栏。
" @see http://liyanrui.is-programmer.com/articles/1791/gvim-menu-and-toolbar-toggle.html
if g:OS#gui
    set guioptions-=m
    set guioptions-=T
    map <silent> <F2> :if &guioptions =~# 'T' <Bar>
            \set guioptions-=T <Bar>
            \set guioptions-=m <bar>
        \else <Bar>
            \set guioptions+=T <Bar>
            \set guioptions+=m <Bar>
        \endif<CR>
endif

if g:OS#gui
    set autochdir
    set colorcolumn=81
    hi colorcolumn guibg=#444444
    " for Vim72-
    "syn match out80 /\%80v./ containedin=ALL
    "hi out80 guifg=#333333 guibg=#ffffff
endif

" 设置宽度不明的文字(如 “”①②→ )为双宽度文本。
" @see http://blog.sina.com.cn/s/blog_46dac66f010006db.html
set ambiwidth=double


" 高亮当前行
" highlight CurrentLine guibg=darkgrey guifg=white
" au! Cursorhold * exe 'match CurrentLine /\%' . line('.') . 'l.*/'
" set ut=100
"
" set cursorcolumn
set cursorline
if g:OS#win
    hi cursorline gui=underline guibg=NONE cterm=underline
endif

set history=500

" Show tab number in your tab line
" @see http://vim.wikia.com/wiki/Show_tab_number_in_your_tab_line
" :h tabline
if g:OS#gui
    " TODO: for MacVim.
    set guitablabel=%N.%t
endif

" 自动换行。
" NOTE: this setting will change text source.
" set textwidth=80
" set fo+=m

" 共享系统剪贴板（yank的时候同时存储到剪贴板中）。
"set clipboard+=unnamed

" 状态栏。
set laststatus=2
set statusline=%t\ %1*%m%*\ %1*%r%*\ %2*%h%*%w%=%l%3*/%L(%p%%)%*,%c%V]\ [%b:0x%B]\ [%{&ft==''?'TEXT':toupper(&ft)},%{toupper(&ff)},%{toupper(&fenc!=''?&fenc:&enc)}%{&bomb?',BOM':''}%{&eol?'':',NOEOL'}]
"let &statusline=' %t %{&mod?(&ro?"*":"+"):(&ro?"=":" ")} %1*|%* %{&ft==""?"any":&ft} %1*|%* %{&ff} %1*|%* %{(&fenc=="")?&enc:&fenc}%{(&bomb?",BOM":"")} %1*|%* %=%1*|%* 0x%B %1*|%* (%l,%c%V) %1*|%* %L %1*|%* %P'
hi User1 guibg=red guifg=yellow
hi User2 guibg=#008000 guifg=white
hi User3 guibg=#C2BFA5 guifg=#999999

" ------------------------------- Mappings ------------------------------ {{{
" Normal Mode, Visual Mode, and Select Mode,
" use <Tab> and <Shift-Tab> to indent
" @see http://c9s.blogspot.com/2007/10/vim-tips.html
"nmap <tab> v>                  " :h ctrl-i :h <tab>
"nmap <s-tab> v<
vmap <tab> >gv
vmap <s-tab> <gv

" 选中一段文字并全文搜索这段文字
vnoremap  *  y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
vnoremap  #  y?<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

" 窗口间的移动设置。
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l
map <C-h> <C-W>h

map <C-kPlus> <C-w>+
map <C-kMinus> <C-w>-
map <C-S-kPlus> <C-w>_
map <C-S-kMinus> <C-w>_

" TODO: smart <Home>

function! RemoveTrailingWhitespace()
    if &ft != "diff"
        let b:curcol = col(".")
        let b:curline = line(".")
        silent! %s/\s\+$//
        silent! %s/\(\s*\n\)\+\%$//
        call cursor(b:curline, b:curcol)
    endif
endfunction
autocmd BufWritePre * call RemoveTrailingWhitespace()
