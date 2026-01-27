" --- COMPATIBILITY ---
set nocompatible

" --- UI & THE SPACE ISSUE ---
set laststatus=2
set showmode
" cursorline might fail in tiny, so we use silent!
silent! set cursorline

" --- SEARCHING ---
set incsearch
set hlsearch
set ignorecase
set smartcase

" --- INDENTATION ---
set expandtab
set shiftwidth=4
set softtabstop=4
set autoindent

" --- QUALITY OF LIFE ---
set backspace=indent,eol,start
set wildmenu

" --- KEY MAPPINGS ---
" Since 'let mapleader' failed, we map the space bar directly
" 'fd' to escape
inoremap fd <Esc>
vnoremap fd <Esc>

" Space + w to write
nnoremap <space>w :w<CR>
" Space + q to quit
nnoremap <space>q :q<CR>

" Clear highlights with Space + Space
nnoremap <space><space> :noh<CR>

" Attempt syntax, but ignore errors
silent! syntax on
