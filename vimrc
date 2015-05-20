filetype off

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

syntax on
filetype plugin indent on

if $TERM =~ '256color'
  set t_Co=256
elseif $TERM =~ '^xterm$'
  set t_Co=256
endif

set cursorline
colorscheme molokai
set number

set autoindent smartindent      " turn on auto/smart indenting
set smarttab                    " make <tab> and <backspace> smarter
set tabstop=8                   " tabstops of 8
set shiftwidth=8                " indents of 8
set backspace=eol,start,indent  " allow backspacing over indent, eol, & start
set undolevels=1000             " number of forgivable mistakes
set updatecount=100             " write swap file to disk every 100 chars
set complete=.,w,b,u,U,t,i,d    " do lots of scanning on tab completion
set viminfo=%100,'100,/100,h,\"500,:100,n~/.vim/viminfo

set ignorecase
set smartcase
set hlsearch
set incsearch
set showmatch

set diffopt=filler,iwhite       " ignore all whitespace and sync

nnoremap <C-g> :NERDTreeToggle<cr>
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$' ]
let NERDTreeHighlightCursorline=1
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1

let g:yankring_history_dir = '$HOME/.vim'

let html_number_lines = 0
let html_ignore_folding = 1
let html_use_css = 1
"let html_no_pre = 0
"let use_xhtml = 1

set ls=2 " Always show status line
if has('statusline')
   function SetStatusLineStyle()
       let &stl="%f %y%([%R%M]%) %#StatusLineNC#%{&ff=='unix'?'':&ff.'\ format'}%* %{'!'[&ff=='".&ff."']}%{'$'[!&list]} (%{synIDattr(synID(line('.'),col('.'),0),'name')})%=%#Search# %{fugitive#statusline()} %#StatusLine# #%n %4.l/%L %3v %3.p%%"
   endfunc
   " Switch between the normal and vim-debug modes in the status line
   nmap _ds :call SetStatusLineStyle()<CR>
   call SetStatusLineStyle()
   " Window title
   if has('title')
      set titlestring=%t%(\ [%R%M]%)
   endif
endif 


command! -nargs=? HighlightLongLines call s:HighlightLongLines('<args>')
function! s:HighlightLongLines(width)
    let targetWidth = a:width != '' ? a:width : 79
    if targetWidth > 0
        exec 'match Todo /\%>' . (targetWidth) . 'v/'
    else
        echomsg "Usage: HighlightLongLines [natural number]"
    endif
endfunction


""""""""""""""""""""""""""""""
" => Minibuffer plugin
""""""""""""""""""""""""""""""
let g:miniBufExplorerMoreThanOne = 10000
let g:miniBufExplModSelTarget = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplSplitBelow=1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplVSplit = 20


map <M-j> :bn<cr>
map <M-k> :bp<cr>

set wildmenu
"set autochdir
set hidden

:command -bar -nargs=1 OpenURL :!firefox <args>

" CleanClose
nmap fc :call CleanClose(1)<cr>
nmap fq :call CleanClose(0)<cr>
function! CleanClose(tosave)
if (a:tosave == 1)
    w!
endif
let todelbufNr = bufnr("%")
let newbufNr = bufnr("#")
if ((newbufNr != -1) && (newbufNr != todelbufNr) && buflisted(newbufNr))
    exe "b".newbufNr
else
    bnext
endif

if (bufnr("%") == todelbufNr)
    new
endif
exe "bd!".todelbufNr
endfunction
""""""""""""""""""""""""""""""""""""""""

let Grep_Skip_Dirs = '.git'
let Grep_Skip_files = '*~ cscope* .svn'
let Grep_Default_Options = '-i -I'
nnoremap <silent> <F6> :Rgrep <CR><CR><CR><CR>

let mapleader=","
let localmapleader=","
map <Leader>ss :setlocal spell!<cr>
map <Leader>/ :nohlsearch<cr>
map <Leader>l :MiniBufExplorer<cr>
map <Leader>c :call setqflist([])<cr>
map <Leader>d :set ft=muttdiff<cr>
map <Leader>g :Ggrep "<C-r><C-w>"<CR>

if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    vnoremap <Leader>y y:call system("pbcopy", getreg("\""))<cr>
    nnoremap <Leader>p :call setreg("\"",system("pbpaste"))<cr>p
  else
    vnoremap <Leader>y "*y
    nnoremap <Leader>p "*p
  endif
endif


set list!
set listchars=tab:▸\ ,trail:•,extends:»,precedes:«

vnoremap . :normal .<CR>
vnoremap @ :normal! @

set undolevels=10000
let xml_use_xhtml = 1

set directory=~/.vim/swap

map <F1> :set lines=75<CR>:set columns=135<CR>
map <F2> :set lines=75<CR>:set columns=210<CR>

nnoremap <F5> :GundoToggle<CR>

let g:syntastic_enable_signs=1
let g:syntastic_mode_map = { 'mode': 'active',
			   \ 'active_filetypes': [],
			   \ 'passive_filetypes': ['c'] }


let g:quickfixsigns_classes=['qfl', 'vcsdiff', 'breakpoints']

" Let mac-vim receive meta-key input
if has("gui_running") && has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
	set invmmta
  endif
endif

""""""""""""""""""""""""""""""""""""""
" Some Vim-LaTeX settings
if has('gui_running')
	let g:tex_flavor='latex'
	let g:Tex_DefaultTargetFormat = 'pdf'
	let g:Tex_ViewRule_pdf = 'Skim'
	let g:Tex_CompileRule_pdf = 'pdflatex -synctex=1 --interaction=nonstopmode $*'
	let g:Tex_UseMakefile = 0
endif
imap <C-k> <Plug>IMAP_JumpForward

" Disable folding
let Tex_FoldedSections=""
let Tex_FoldedEnvironments=""
let Tex_FoldedMisc=""


""""""""""""""""""""""""""""""""""""""
" When I write assembly, I write ARM assembly
au BufNewFile,BufRead *.S set filetype=armasm

""""""""""""""""""""""""""""""""""""""
" Pipe cr kernel buffer into appropriately named file: voila colors
au BufNewFile,BufRead *.crdmesg set filetype=crdmesg

""""""""""""""""""""""""""""""""""""""
" Get rid of some very annoying warnings opening stdin

"compiler gcc
"set errorformat^=%-G<stdin>:%l:2:\ warning:\ #warning\ syscall\ process_vm_readv\ not\ implemented\ [-Wcpp]
"set errorformat^=%-G<stdin>:%l:2:\ warning:\ #warning\ syscall\ process_vm_writev\ not\ implemented\ [-Wcpp]
"set errorformat^=%-G<stdin>:%l:2:\ warning:\ #warning\ \"TODO:\ return_address\ should\ user\ unwind\ tables\"
"set errorformat^=%-G<stdin>:%l:2:\ warning:\ #warning\ \"TODO:\ return_address\ should\ user\ unwind\ tables\"\ [-Wcpp]
"set errorformat^=%-G<stdin>:%l:2:\ warning:\ \'offset.un\'\ may\ be\ used\ uninitialized\ in\ this\ function\ [-Wuninitialized]
"set errorformat^=%-G<stdin>:%l:2:\ note:\ \'offset.un\'\ was\ declared\ here


"""""""""""""""""""""""""""""""""""""
" Remap autocomplete to ctrl+space
if has("gui_running")
    " C-Space seems to work under gVim on both Linux and win32
    inoremap <C-Space> <C-n>
else " no gui
  if has("unix")
    inoremap <Nul> <C-n>
  else
  " I have no idea of the name of Ctrl-Space elsewhere
  endif
endif


""""""""""""""""""""""""""""""""""""""
" Remap C-n and C-p to to navigate the quickfix next-previous in normal mode
nmap <C-p> :cprev<cr>
nmap <C-n> :cnext<cr>
