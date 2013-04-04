runtime bundle/vim-pathogen/autoload/pathogen.vim

filetype off

let mapleader = ","

" call pathogen#infect()
" Use pathogen.vim to manage and load plugins
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

syntax on
filetype plugin indent on
set smarttab
set autoindent

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

set ts=2 sts=2 sw=2 expandtab

"
" appearance options
"
let g:zenburn_high_Contrast = 1
let g:liquidcarbon_high_contrast = 1
let g:molokai_original = 0
set t_Co=256
colorscheme mustang
set bg=dark

if has("gui_running")
  " set default size: 90x35
  set columns=90
  set lines=35
  " No menus and no toolbar
  set guioptions-=m
  set guioptions-=T
  let g:obviousModeInsertHi = "guibg=Black guifg=White"
else
  let g:obviousModeInsertHi = "ctermfg=253 ctermbg=16"
endif

set modeline
set wildchar=9 " tab as completion character

set virtualedit=block
set clipboard+=unnamed  " Yanks go on clipboard instead.
set showmatch " Show matching braces.

" Line wrapping on by default
set wrap
set linebreak

set guifont=Monaco

set history=1000 " keep track of last commands
set number ruler " show line numbers
set incsearch " incremental searching on
set hlsearch " highlight all matches
set smartcase
set cursorline
set selectmode=key
set showtabline=2 " show always for console version
set tabline=%!MyTabLine()
set wildmenu " menu on statusbar for command autocomplete
" default to UTF-8 encoding
set encoding=utf8
set fileencoding=utf8
" enable visible whitespace
set listchars=tab:»·,trail:·,precedes:<,extends:>
set list
set hidden
set ignorecase
set smartcase
set title
set scrolloff=3
set backupdir=~/tmp/.vim/backup//,~/.tmp//,~/tmp//,/var/tmp//,/tmp//
set directory=~/tmp/.vim/swap//,~/.tmp//,~/tmp//,/var/tmp//,/tmp//

" Intuitive backspacing in insert mode
set backspace=indent,eol,start

" Keep undo history even after closing a file.
set undofile
set undodir=~/tmp/.vim/undo//,~/.tmp//,~/tmp//,/var/tmp//,/tmp//

" Save file on losing focus
" au FocusLost * :wa

" Split vertically and focus on <leader>w
nnoremap <leader>w <C-w>v<C-w>l

" no beep
autocmd VimEnter * set vb t_vb=

" tab navigation like firefox
nmap <C-S-tab> :tabprevious<cr>
nmap <C-tab> :tabnext<cr>
map <C-S-tab> :tabprevious<cr>
map <C-tab> :tabnext<cr>
imap <C-S-tab> <ESC>:tabprevious<cr>i
imap <C-tab> <ESC>:tabnext<cr>i
nmap <C-t> :tabnew<cr>
imap <C-t> <ESC>:tabnew<cr>
" map \tx for the console version as well
if !has("gui_running")
  nmap <Leader>tn :tabnext<cr>
  nmap <Leader>tp :tabprevious<cr>
  nmap <Leader><F4> :tabclose<cr>
end

" Map Ctrl-E Ctrl-W to toggle linewrap option like in VS
noremap <C-E><C-W> :set wrap!<CR>
" Map Ctrl-M Ctrl-L to expand all folds like in VS
noremap <C-M><C-L> :%foldopen!<CR>
" Remap omni-complete to avoid having to type so fast
inoremap <C-Space> <C-X><C-O>

" disable warnings from NERDCommenter:
let g:NERDShutUp = 1

" Make sure taglist doesn't change the window size
let g:Tlist_Inc_Winwidth = 0
nnoremap <silent> <F8> :TlistToggle<CR>

" language specific customizations:
let g:python_highlight_numbers = 1

" set custom file types I've configured
au BufNewFile,BufRead *.ps1  setf ps1
au BufNewFile,BufRead *.boo  setf boo
au BufNewFile,BufRead *.config  setf xml
au BufNewFile,BufRead *.xaml  setf xml
au BufNewFile,BufRead *.xoml  setf xml
au BufNewFile,BufRead *.blogTemplate  setf xhtml
au BufNewFile,BufRead *.brail  setf xhtml
au BufNewFile,BufRead *.rst  setf xml
au BufNewFile,BufRead *.rsb  setf xml
au BufNewFile,BufRead *.io  setf io
au BufNewFile,BufRead *.notes setf notes
au BufNewFile,BufRead *.mg setf mg

"
" Bind NERD_Tree plugin to a <Ctrl+E,Ctrl+E>
"
noremap <C-E><C-E> :NERDTree<CR>
noremap <C-E><C-C> :NERDTreeClose<CR>

" 
" Configure tabs for the console version
"
function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'

    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999Xclose'
  endif

  return s
endfunction

function! MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  return bufname(buflist[winnr - 1])
endfunction

"
" Status line configuration gotten from: http://rgarciasuarez.free.fr/dotfiles/vimrc
"
set ls=2 " Always show status line
if has('statusline')
  " Status line detail:
  " %f		file path
  " %y		file type between braces (if defined)
  " %([%R%M]%)	read-only, modified and modifiable flags between braces
  " %{'!'[&ff=='default_file_format']}
  "			shows a '!' if the file format is not the platform
  "			default
  " %{'$'[!&list]}	shows a '*' if in list mode
  " %{'~'[&pm=='']}	shows a '~' if in patchmode
  " (%{synIDattr(synID(line('.'),col('.'),0),'name')})
  "			only for debug : display the current syntax item name
  " %=		right-align following items
  " #%n		buffer number
  " %l/%L,%c%V	line number, total number of lines, and column number
  function! SetStatusLineStyle()
    if &stl == '' || &stl =~ 'synID'
      let &stl="%f %y%([%R%M]%)%{'!'[&ff=='".&ff."']}%{'$'[!&list]}%{'~'[&pm=='']}%=#%n %l/%L,%c%V "
    else
      let &stl="%f %y%([%R%M]%)%{'!'[&ff=='".&ff."']}%{'$'[!&list]} (%{synIDattr(synID(line('.'),col('.'),0),'name')})%=#%n %l/%L,%c%V "
    endif
  endfunc
  " Switch between the normal and vim-debug modes in the status line
  nmap _ds :call SetStatusLineStyle()<CR>
  call SetStatusLineStyle()
  " Window title
  if has('title')
    set titlestring=%t%(\ [%R%M]%)
  endif
endif

" For .coffee files
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

" For .py files
au BufNewFile,BufReadPost *.py setl ts=4 sw=4 sta et sts=4 ai

" For erlang files
au BufNewFile,BufReadPost *.erl setl ts=4 sw=4 sta et sts=4 ai
au BufNewFile,BufReadPost *.erh setl ts=4 sw=4 sta et sts=4 ai

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Disable arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Force saving files that require root permission
cmap w!! %!sudo tee > /dev/null %

" select all text in current buffer
map <Leader>a ggVG

" Fuzzy Finder
nmap <Leader>ff :FufCoverageFile<CR>
nmap <Leader>fb :FufBuffer<CR>
nmap <Leader>fl :FufLine<CR>
nmap <Leader>fr :FufRenewCache<CR>
