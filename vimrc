" Standard vim options
  set autoindent            " always set autoindenting on
  set backspace=2           " allow backspacing over everything in insert mode
  set cindent shiftwidth=4  " Same thing with cindent
  set diffopt=filler,iwhite " keep files synced and ignore whitespace
  set expandtab             " Get rid of tabs altogether and replace with spaces
" set foldcolumn=2          " set a column incase we need it
" set foldlevel=0           " show contents of all folds
" set foldmethod=indent     " use indent unless overridden
  set guioptions-=m         " Remove menu from the gui
  set guioptions-=T         " Remove toolbar
  set hidden                " hide buffers instead of closing
  set history=50            " keep 50 lines of command line history
  set ignorecase            " Do case insensitive matching
  set incsearch             " Incremental search
  set laststatus=2          " always have status bar
  set linebreak             " This displays long lines as wrapped at word boundries
  set matchtime=10          " Time to flash the brack with showmatch
  set nobackup              " Don't keep a backup file
  set nocompatible          " Use Vim defaults (much better!)
  set nofen                 " disable folds
  set notimeout             " i like to be pokey
  set nottimeout            " take as long as i like to type commands
  set ruler                 " the ruler on the bottom is useful
  set scrolloff=1           " dont let the curser get too close to the edge
  set shiftwidth=4          " Set indention level to be the same as softtabstop
  set showcmd               " Show (partial) command in status line.
  set showmatch             " Show matching brackets.
  set softtabstop=4         " Why are tabs so big?  This fixes it
  set textwidth=0           " Don't wrap words by default
" set textwidth=80          " This wraps a line with a break when you reach 80 chars
  set timeoutlen=10000      " Time to wait for a map sequence to complete
  set ttimeoutlen=10000     " time to wait for a key code to complete
  set virtualedit=block     " let blocks be in virutal edit mode
  set wildmenu              " This is used with wildmode(full) to cycle options
  set mouse=                " Set mouse mode in vim
  set ts=4                  " Set tab to 4 space
  set ff=unix

"Disabled options
  "set list                    " Make tabs and trails explicit
  "set noswapfile              " this guy is really annoyoing sometimes
  "set wrapmargin=80           " When pasteing, use this, because textwidth becomes 0
                               " wrapmargin inserts breaks if you exceed its value
  "set cscopeprg=~/bin/cscope  "set cscope bin path

"Set colorscheme.  This is a black background colorscheme
  colorscheme darkblue

"Turn on syntax highlighting
" syntax on

"When editing a file, make screen display the name of the file you are editing
function! SetTitle()
  if $TERM =~ "^screen"
    let l:title = 'vi: ' . expand('%:t')        
    
    if (l:title != 'vi: __Tag_List__')
      let l:truncTitle = strpart(l:title, 0, 15)
      silent exe '!echo -e -n "\033k' . l:truncTitle . '\033\\"'     
    endif
  endif
endfunction

" Run it every time we change buffers
autocmd BufEnter,BufFilePost * call SetTitle()

" key binding
map j gj
map k gk

" auto remove trailing whitespace
keepjumps autocmd BufWritePre *.js :%s/\s\+$//e
execute pathogen#infect()
syntax on
filetype plugin indent on

autocmd FileType javascript noremap <buffer>  <c-a-f> :call JsBeautify()<cr>
