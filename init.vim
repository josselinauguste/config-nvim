execute pathogen#infect()

syntax on
filetype plugin indent on

set nocompatible
set number                     " Show current line number
set relativenumber             " Show relative line numbers
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
set ignorecase                    " Ignore case in search
set smartcase                     " Do not ignore case if case is used in search
set incsearch                     " Start searching before pressing enter
set hidden

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

color one
set background=light
highlight Pmenu ctermbg=238 gui=bold 

" Show wrap guide
set colorcolumn=100

let mapleader = ','

set wildignore+=*.bs.js
set wildignore+=node_modules
set wildignore+=.git

" vimdiff
set diffopt+=iwhite
if &diff
  highlight! link DiffText MatchParen
endif

" Reduce refresh time for git-gutter
set updatetime=250

" Grepper
nnoremap <leader>g :Grepper -tool git<cr>
nnoremap <leader>G :Grepper -tool ag<cr>

" Markdown
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_folding_disabled = 1

" Buffers
" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>
" Move to the next buffer
nmap <leader>l :bnext<CR>
" Move to the previous buffer
nmap <leader>h :bprevious<CR>
" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>
" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" Airline
let g:airline#extensions#tabline#enabled = 1
" Disable powerline fonts.
let g:airline_powerline_fonts = 1 
let g:airline_theme='one'

" CtrlP
" Ignore files in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
" Open file menu
nnoremap <Leader>o :CtrlP<CR>
" Open buffer menu
nnoremap <Leader>b :CtrlPBuffer<CR>
" Open most recently used files
nnoremap <Leader>f :CtrlPMRUFiles<CR>

" Language server
" Required for operations modifying multiple buffers like rename.
let g:LanguageClient_serverCommands = {
    \ 'reason': ['ocaml-language-server', '--stdio'],
    \ 'ocaml': ['ocaml-language-server', '--stdio'],
    \ 'haskell': ['hie', '--lsp'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ }
 
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> gf :call LanguageClient_textDocument_formatting()<CR>

" Neoformat
let g:neoformat_run_all_formatters = 1
let g:neoformat_only_msg_on_error = 1
let g:neoformat_try_formatprg = 0

let g:neoformat_enabled_haskell = ['stylishhaskell']

augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

" Ale - provides linting (neomake like)
let g:airline#extensions#ale#enabled = 1

nnoremap <buffer> <silent> <LocalLeader>= :ALEFix<CR>
let g:ale_fix_on_save = 1

" Haskell-vim
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

