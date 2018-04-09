
execute pathogen#infect()
syntax on
syntax enable
set background=dark
colorscheme solarized
set laststatus=2
set number
set mouse=r
set backspace=2 " make backspace work like most other programs
set hidden
set smarttab
set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
filetype indent on
set hlsearch
set ignorecase
set smartcase
set runtimepath^=~/.vim/bundle/ctrlp.vim
set cursorline                        " highlight current line
set fillchars=vert:┃ 
set incsearch
set backspace=indent,start,eol
set highlight+=@:ColorColumn          " ~/@ at end of window, 'showbreak'
set highlight+=N:DiffText             " make current line number stand out a little
set highlight+=c:LineNr               " blend vertical separators with line numbers
set showcmd
set clipboard=unnamed
highlight SignColumn ctermbg=0

if exists('$SUDO_USER')
  set nobackup                        " don't create root-owned files
  set nowritebackup                   " don't create root-owned files
else
  set backupdir=~/local/.vim/tmp/backup
  set backupdir+=~/.vim/tmp/backup    " keep backup files out of the way
endif

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen = 1

let g:airline_solarized_bg='dark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let mapleader = ","
nmap <leader>t :TagbarToggle<CR>
nmap <leader>n :NERDTreeToggle<CR>

" Move VISUAL LINE selection within buffer.
xnoremap <silent> K :call s:Move_Up()<CR>
xnoremap <silent> J :call s:Move_Down()<CR>

" Powerline fance
let g:Powerline_symbols = 'fancy'
let g:airline_powerline_fonts = 1

" Save location where I was when I closed the file
" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<ENTER>'
let g:ycm_key_list_stop_completion = ['<ENTER>']
let g:ycm_warning_symbol = "\uf12a"
let g:ycm_error_symbol = "✗"


" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" IndentLine Plugin
let g:indentLine_char = '┆'

" Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-dispatch'
Plugin 'ervandew/supertab'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-unimpaired'
Plugin 'will133/vim-dirdiff'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'ryanoasis/vim-devicons'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'mileszs/ack.vim'
Plugin 'matchit.zip'
Plugin 'Yggdroot/indentLine'
Plugin 'mhinz/vim-startify'

call vundle#end()            " required
filetype plugin indent on    " required


set autoindent
set smartindent
set cindent

function! s:Visual()
  return visualmode() == 'V'
endfunction

function! s:Move(address, at_limit)
  if s:Visual() && !a:at_limit
    execute "'<,'>move " . a:address
    call feedkeys('gv=', 'n')
  endif
  call feedkeys('gv', 'n')
endfunction

function! s:Move_Up() abort range
  let l:at_top=a:firstline == 1
  call s:Move("'<-2", l:at_top)
endfunction

function! s:Move_Down() abort range
  let l:at_bottom=a:lastline == line('$')
  call s:Move("'>+1", l:at_bottom)
endfunction

function! StartifyEntryFormat()
    return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction
