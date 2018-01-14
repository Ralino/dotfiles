

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

set nocompatible

set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'junegunn/fzf.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'sheerun/vim-polyglot'
Plugin 'vim-syntastic/syntastic'
"Plugin 'nvie/vim-flake8'

call vundle#end()
filetype plugin indent on


" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup      " do not keep a backup file, use versions instead
else
  set backup        " keep a backup file (restore to previous version)
  set undofile      " keep an undo file (undo changes after closing)
endif
set history=50      " keep 50 lines of command line history
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set incsearch       " do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch off highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set nohlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

endif " has("autocmd")

set autoindent        " ALWAYS always set autoindenting on

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif

" gui options
if has("gui_running")
  set guioptions-=e
  set guioptions-=m
  set guioptions-=T
  set guioptions-=L
endif

" Set colorscheme
if has("gui_running")
    colorscheme gruvbox
    let g:airline_theme='gruvbox'
    set background=dark
else
    colorscheme gruvbox
    let g:airline_theme='gruvbox'
    hi Normal ctermbg=none
    set background=dark
    autocmd VimEnter * hi Normal ctermbg=none
endif

" Disable bell
set vb
set t_vb=

"Command to remove trailing whitespace
if !exists(":Retrail")
    command Retrail :%s/\s\+$//e
endif

"Map :W to :w for mistyping
if !exists(":W")
    command W :w
endif
if !exists(":Wq")
    command Wq :wq
endif
if !exists(":WQ")
    command WQ :wq
endif
if !exists(":Q")
    command Q :q
endif

"Allow saving of files as sudo
if !exists(":SudoW")
    command SudoW w !sudo tee > /dev/null %
endif

" Mappings to switch buffers
nnoremap gb :bn<CR>
nnoremap gB :bp<CR>

" Set directory for swapfiles, undo and backups to make cleaning easier
set backupdir=~/.vim/tmp,.
set undodir=~/.vim/tmp,.
set dir=~/.vim/tmp,.

" Other settings
set number

set tabstop=2
set shiftwidth=2
set softtabstop=2 expandtab
set smarttab

" For vim-latexsuite
filetype plugin indent on
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"

" YouCompleteMe settings
let g:ycm_server_python_interpreter = "/usr/bin/python2"
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_python_binary_path = 'python'
let g:ycm_confirm_extra_conf = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_error_symbol = ''
let g:ycm_warning_symbol = ''
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_complete_in_comments = 1
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
nnoremap <F6> :YcmCompleter GoTo<CR>
nnoremap <F7> :YcmCompleter FixIt<CR>
if !exists(':Yr')
  command Yr :YcmForceCompileAndDiagnostics
endif
if !exists(':Yg')
  command Yg :YcmCompleter GoTo
endif
if !exists(':Yf')
  command Yf :YcmCompleter FixIt
endif
if !exists(':Yt')
  command Yt :YcmCompleter GetType
endif

" Syntastic settings
let g:syntastic_check_on_wq = 0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_error_symbol = ''
let g:syntastic_warning_symbol = ''
let g:syntastic_style_error_symbol = ''
let g:syntastic_style_warning_symbol = ''

" Airline settings
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_left_alt_sep = '|'
let g:airline_left_sep = ' '
let g:airline_right_alt_sep = '|'
let g:airline_right_sep = ' '
set ttimeoutlen=10

"Gitgutter
set updatetime=250
let g:gitgutter_map_keys = 0

" NERDtree
if !exists(':Nt')
  command Nt :NERDTreeToggle
endif
if !exists(':Ntf')
  command Ntf :NERDTreeFind
endif

" FZF
if !exists(':Fb')
  command Fb :Buffers
endif
if !exists(':Ff')
  command Ff :Files
endif
if !exists(':Fl')
  command Fl :BLines
endif
if !exists(':Fla')
  command Fla :Lines
endif

" Tagbar
if !exists(':Tb')
  command Tb :TagbarToggle
endif

" disable overkill c++ syntax highlighting
let g:polyglot_disabled = ['c++11','c/c++']

" OpenGL syntax settings
au BufNewFile,BufRead,BufEnter *.frag,*.vert,*.fp,*.glsl setf glsl

" ROS launch files
au BufNewFile,BufRead,BufEnter *.launch setf xml

" Easier window navigation
nnoremap <silent> <c-l> :wincmd l<CR>
nnoremap <silent> <c-h> :wincmd h<CR>
nnoremap <silent> <c-k> :wincmd k<CR>
nnoremap <silent> <c-j> :wincmd j<CR>

" Stop latex suite from overwriting my keymaps
nmap <SID>idontneedthis <Plug>IMAP_JumpForward
" imap <SID>idontneedthis <Plug>IMAP_JumpForward
vmap <SID>idontneedthis <Plug>IMAP_JumpForward

runtime! ftplugin/man.vim
