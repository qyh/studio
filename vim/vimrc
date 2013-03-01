syntax enable
"set background=dark
"colorscheme solarized
syntax on

" 打开对文件类型插件的支持
filetype indent on
filetype plugin on
filetype plugin indent on

" ######### VimWiki 写作助手 ######### "

" 使用鼠标映射
let g:vimwiki_use_mouse = 1

" 不要将驼峰式词组作为 Wiki 词条
let g:vimwiki_camel_case = 0


set history=800
set nu
set expandtab
set tabstop=4
set smarttab
set shiftwidth=4

set lbr
set tw=500

set autoindent
set cindent
set nocompatible
set backspace=2
set pastetoggle=<F9>

set encoding=utf8

""""""""""""""""""""""""""""""
" Tag list (ctags)
"""""""""""""""""""""""""""""""
nnoremap <silent> <F8> :TlistToggle<CR>
nnoremap <silent> <F2> :help taglist.txt<CR>
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Show_One_File = 0 " Show the only tag window of the current file ?
let Tlist_Exit_OnlyWindow = 1 " Exit vim when taglist window is the last window
let Tlist_Use_Left_Window = 1 " Show taglist window on the left
let Tlist_GainFocus_On_ToggleOpen = 0 " Do not focus on taglist window when it's open.

fun SetupVAM()
    set runtimepath+=~/.vim/addons/vim-addon-manager
endf
"call SetupVAM()
