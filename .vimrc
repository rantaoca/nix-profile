" Allowing unsaved hidden buffers.
set hidden

" vv to generate new vertical split
nnoremap <silent> vv <C-w>v

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

" Set indent to 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Ignore case sensitivity on searches
set ignorecase

" Show hybrid line numbers
set number relativenumber

" Automatically change directory to the current file.
set autochdir

" Enable mouse mode
set mouse=a

" Set highlight characters over 80
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" Set text width to 80
set tw=80

" Search and replace hotkey with \s
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

<<<<<<< HEAD
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

" Diff unsaved changes
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" Remove netrw directory listing header
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 80
let g:netrw_altv = 1

" Sort with files with .h and .cc next to each other.
let g:netrw_sort_sequence = '[\/]$,\<core\%(\.\d\+\)\=\>,\.(h|cc)$,\.c$,\.cpp$,\~\=\*$,*,\.o$,\.obj$,\.info$,\.swp$,\.bak$,\~$'

" Change Vim's folding syntax color
hi Folded ctermbg=black

"================================================================
" Custom Commands

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
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Plugin specific settings

" Airline
" Enable buffers to show as tabs when no tabs are active
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 0
let g:airline_powerline_fonts = 1
"===============================================================
" Pathogen Plugin Manager
execute pathogen#infect()

" Nerd Tree set default split to go to the right instead of left
set splitright
