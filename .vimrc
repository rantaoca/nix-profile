" Use vim features, not needing backward compat with vi
set nocompatible

" Probably don't need filetype off...
" filetype off
filetype plugin indent on 

" Allowing unsaved hidden buffers.
set hidden

" Enable mouse mode
set mouse=a

" Theme
set background=dark
set term=xterm-256color

" General format
set tabstop=2
set softtabstop=2
set shiftwidth=2
"set textwidth=80
set wrap
set expandtab
set autoread
set autoindent
set fileformat=unix

" Set indent to 2 spaces
au BufNewFile,BufRead *.cpp,*.h
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2

" Python config
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4

" Ignore case sensitivity on searches
set ignorecase

" Set highlight characters over X
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
au BufRead,BufNewFile *.py match OverLength /\%101v.\+/
au BufRead,BufNewFile *.cpp,*.h match OverLength /\%81v.\+/

" Default clipboard to system clipboard
set clipboard=unnamedplus

" Show invisible trailing charaters.
" set listchars=tab:•\ ,trail:•,extends:»,precedes:« " Unprintable chars mapping
" set invlist 

" Show hybrid line numbers
" set number relativenumber

" Automatically change directory to the current file.
" set autochdir



"================================================================
" Folding

" Change Vim's folding syntax color
hi Folded ctermbg=black

" Set folding. Using syntax fold method is really slow.
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za


"================================================================
" Hotkeys

" ctrl-w | to generate new vertical split
nnoremap <C-w>\| <C-w>v

" ctrl-w _ to generate new horizontal split
nnoremap <C-w>_ <C-w>s

" Search and replace hotkey with \s
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" Paste from system clipboard
nnoremap <Leader>p :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>

" Copy selection to system clipboard
nnoremap <Leader>y :.w !pbcopy<CR><CR>
vnoremap <Leader>y :'<,'>w !pbcopy<CR><CR>

" Replace word with copy buffer 0\s
nnoremap <Leader>r ciw<C-r>0<Esc>

" Replace selected text with copy buffer 0\s
vnoremap <Leader>r c<C-r>0<Esc>

" Enable paste mode
nnoremap <Leader>p :set invpaste<cr>

" Set tab autocompletion to display matches.
set wildchar=<Tab> wildmenu wildmode=full

com! Ranvim edit ~/.ranconf/.vimrc
com! Source source ~/.vimrc

" Diff unsaved changes
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" \v to paste from clipboard.
nnoremap <Leader>v :set paste<CR>

" \y in visual mode to yank selection into tmux buffer
function! TmuxSharedYank()
  " Send the contents of the 't' register to a temporary file, invoke
  " copy to tmux using load-buffer.
  let tmpfile = tempname()
  call writefile(split(@t, '\n'), tmpfile, 'b')
  call system('tmux load-buffer '.shellescape(tmpfile))
  call delete(tmpfile)
endfunction
vnoremap <Leader>y "ty:call TmuxSharedYank()<cr>

" tab in normal mode to switch to last opened buffer.
nmap <tab> :b#<cr>

" Disable Arrow keys in Escape mode
"map <up> <nop>
"map <down> <nop>
"map <left> <nop>
"map <right> <nop>

" Disable Arrow keys in Insert mode
"imap <up> <nop>
"imap <down> <nop>
"imap <left> <nop>
"imap <right> <nop>

" Allow switching ctrl-j/k to switch up an down to tmux pane while in nerdtree
let g:NERDTreeMapJumpNextSibling = '<Nop>'
let g:NERDTreeMapJumpPrevSibling = '<Nop>'

"================================================================
" Netrw

" Remove netrw directory listing header
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 80
let g:netrw_altv = 1

" Sort with files with .h and .cc next to each other.
let g:netrw_sort_sequence = '[\/]$,\<core\%(\.\d\+\)\=\>,\.(h|cc)$,\.c$,\.cpp$,\~\=\*$,*,\.o$,\.obj$,\.info$,\.swp$,\.bak$,\~$'


"================================================================
" Vim-Plug plugin manager

" Auto install vim plug, plugin manager
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Vim Plug packages
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'  " Fuzzy search files
"Plug 'Valloric/YouCompleteMe'
Plug 'rhysd/vim-clang-format'
Plug 'kana/vim-operator-user'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-abolish'  " Substitute between camel and snake case.
Plug 'luchermitte/lh-vim-lib'  " Required by alternate-lite
Plug 'luchermitte/alternate-lite'  " Switch between .cpp and .h files.
Plug 'kien/ctrlp.vim'  " Search files and buffers like sublime
Plug 'tpope/vim-fugitive'  " vim git tools
Plug 'Konfekt/FastFold'  " Make foldmethod=syntax faster
Plug 'vim-scripts/indentpython'  " Python indentation

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Plugin specific settings

" Airline
" Enable buffers to show as tabs when no tabs are active
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 0
let g:airline_powerline_fonts = 1

"  Vim clang format
autocmd FileType c,cpp ClangFormatAutoEnable

" Alternate-lite config
call lh#alternate#version()  " We need to call an lh#alternate function before setting any configs.
" alternate.lite search path for kinema. Searches .h and .cpp files in {name}/src and
" {name}/include/{name}.
"let g:alternates.searchpath = 'sfr:.,reg:#\([^/]*\)/include/[^/]*#\1/src#g#,reg:#\([^/]*\)/src$#\1/include/\1#g#'
