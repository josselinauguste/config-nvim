execute pathogen#infect()

syntax on
filetype plugin indent on

set nocompatible
set number
set showmode
set smartcase
set smarttab
set smartindent
set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2
set laststatus=2
set autoread                      " reload file if the file changes on the disk
set autowrite                     " write when switching buffers
set autowriteall                  " write on :quit
set cursorline                    " highlight the current line for the cursor
set noerrorbells                  " No bells!
set novisualbell                  " I said, no bells!
set title                         " let vim set the terminal title

set background=dark
color dracula

let mapleader = ','

" Reduce refresh time for git-gutter
set updatetime=250

" Airline
let g:airline#extensions#tabline#enabled = 1
" Disable powerline fonts.
let g:airline_powerline_fonts = 0

" CtrlP
" Ignore files in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" Language server
" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'reason': ['ocaml-language-server', '--stdio'],
    \ 'ocaml': ['ocaml-language-server', '--stdio'],
    \ }

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> gf :call LanguageClient_textDocument_formatting()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

" Neomake
" let g:neomake_error_sign   = {'text': '✖', 'texthl': 'NeomakeErrorSign'}
" let g:neomake_warning_sign = {'text': '∆', 'texthl': 'NeomakeWarningSign'}
" let g:neomake_message_sign = {'text': '➤', 'texthl': 'NeomakeMessageSign'}
" let g:neomake_info_sign    = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}
