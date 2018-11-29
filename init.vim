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
set splitbelow
set splitright

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
if $LIGHT == '1'
  set background=light
  highlight Pmenu ctermbg=238 gui=bold 
endif

" Show wrap guide
set colorcolumn=100

nnoremap <SPACE> <Nop>
let mapleader = ' '

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

" FZF
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

nnoremap <leader>p :FZF<cr>
nnoremap <leader>bb :Buffers<cr>
nnoremap <leader>f :Ag<cr>

" Dash
nmap <silent> <leader>d <Plug>DashSearch

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

" Airline
let g:airline#extensions#tabline#enabled = 1
" Disable powerline fonts.
let g:airline_powerline_fonts = 1 
let g:airline_theme='one'

" Language server
" Required for operations modifying multiple buffers like rename.
let g:LanguageClient_serverCommands = {
    \ 'reason': ['ocaml-language-server', '--stdio'],
    \ 'ocaml': ['ocaml-language-server', '--stdio'],
    \ 'haskell': ['hie-wrapper'],
    \ 'python': ['pyls'],
    \ }

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> gf :call LanguageClient#textDocument_formatting()<CR>
nnoremap <silent> gu :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> ga :call LanguageClient#textDocument_codeAction()<CR>
nnoremap <silent> gs :call LanguageClient#textDocument_documentSymbol()<CR>

" Neoformat
" let g:neoformat_run_all_formatters = 1
let g:neoformat_only_msg_on_error = 1
let g:neoformat_try_formatprg = 0

augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

" Ale - provides linting (neomake like)
let g:airline#extensions#ale#enabled = 1

let g:ale_set_loclist = 0 " one per file
let g:ale_set_quickfix = 1 " one global

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

