" Allowing unsaved hidden buffers.
set hidden

" vv to generate new vertical split
nnoremap <silent> vv <C-w>v

" Disable Arrow keys in Escape mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Disable Arrow keys in Insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Set indent to 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Ignore case sensitivity on searches
set ignorecase

" Automatically change directory to the current file.
set autochdir

" Set highlight characters over 80
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/ 

" Search and replace hotkey with \s
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" Remove netrw directory listing header
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 80
let g:netrw_altv = 1


"================================================================
" Plugins


" Plugin specific settings

" Airline
" Enable buffers to show as tabs when no tabs are active
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 0
let g:airline_powerline_fonts = 1

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

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

