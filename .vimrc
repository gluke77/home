" Installation:
"   - curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   - :PlugInstall

set nocompatible              " be iMproved, required

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'ConradIrwin/vim-bracketed-paste' 
Plug 'tomasiser/vim-code-dark'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
call plug#end()            " required

" colorscheme desert
" colorscheme industry
colorscheme codedark

" set background=dark
set modelines=0 " prevent some security exploits thru modelines
set number
set ruler
set mouse=a
set showcmd
set showmode
set autoindent
set cursorline
set visualbell
set ttyfast
set backspace=indent,eol,start

set gdefault
set showmatch
set ignorecase
set smartcase
set incsearch
set hlsearch

set foldmethod=indent
set foldlevel=99
set encoding=utf-8

set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4

set wildmenu
set noswapfile

set scrolloff=7

" let mapleader = ","
" let mapleader = "\" " original value

:imap jj <Esc>


function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files' s:find_git_root()

" fzf
nnoremap <leader>f :ProjectFiles <CR>
nnoremap <leader>F :Files ~<CR>
nnoremap <leader>l :Lines<CR>
nnoremap <leader>b :Buffers<CR>

nnoremap <leader>B :ls<CR>:b
nnoremap <leader>t :tabnew<CR>

nnoremap <leader>n :NERDTreeTabsToggle<CR>

nnoremap <leader>T :belowright terminal<CR>

nnoremap <nowait><silent> <c-l> :noh<CR>

let python_highlight_all=1
au FileType python set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅
au FileType python nnoremap <leader>r :!python3 %<CR>
au BufWritePre *.py :%s/\s\+$//e

au FileType go set noexpandtab

