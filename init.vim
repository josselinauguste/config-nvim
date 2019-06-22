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
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more iformation.)
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

" Clipboard
set clipboard=unnamedplus

let light_env=$LIGHT
if light_env == '1'
  set background=light
  color one
  highlight Pmenu ctermbg=238 gui=bold
else
  set background=dark
  colorscheme solarized8
endif

" Show wrap guide
set colorcolumn=100

nnoremap <SPACE> <Nop>
let mapleader = ' '

set wildignore+=*.bs.js
set wildignore+=node_modules
set wildignore+=.git
set wildignore+=*.pyc
set wildignore+=.DS_Store

" comments

call tcomment#type#Define('fsharp', '// %s')

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
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>f :Ag<cr>

" Dash
nmap <silent> <leader>d <Plug>DashSearch

" Markdown
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_folding_disabled = 1

" Buffers

" Airline
" let g:airline#extensions#tabline#enabled = 1
" Disable powerline fonts.
let g:airline_powerline_fonts = 1
if light_env == '1'
  let g:airline_theme='one'
else
  let g:airline_theme='solarized'
endif

" Deoplete
let g:deoplete#enable_at_startup = 1

" Language server
" Required for operations modifying multiple buffers like rename.
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'reason': ['ocaml-language-server', '--stdio'],
    \ 'ocaml': ['ocaml-language-server', '--stdio'],
    \ 'haskell': ['hie-wrapper'],
    \ 'python': ['python -m pyls'],
    \ 'fsharp': ['dotnet', '~/Code/fsharp-language-server/src/FSharpLanguageServer/bin/Release/netcoreapp2.0/FSharpLanguageServer.dll'],
    \ 'html': ['nvm exec html-languageserver', '--stdio'],
    \ 'css': ['nvm exec css-languageserver', '--stdio'],
    \ 'json': ['nvm exec json-languageserver', '--stdio'],
    \ 'go': ['gopls'],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
map <Leader>lk :call LanguageClient#textDocument_hover()<CR>
map <Leader>lg :call LanguageClient#textDocument_definition()<CR>
map <Leader>lr :call LanguageClient#textDocument_rename()<CR>
map <Leader>lf :call LanguageClient#textDocument_formatting()<CR>
map <Leader>lb :call LanguageClient#textDocument_references()<CR>
map <Leader>la :call LanguageClient#textDocument_codeAction()<CR>
map <Leader>ls :call LanguageClient#textDocument_documentSymbol()<CR>
map <Leader>le :call LanguageClient#explainErrorAtPoint()<CR>

" let g:LanguageClient_loggingFile = expand("~/.local/share/nvim/LanguageClient.log")
" let g:LanguageClient_loggingLevel = 'DEBUG'

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

