"--- _vimrc

" Can be used to detect GUI when necessary
"if has('gui_running')
"endif

" https://github.com/tpope/vim-pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" let mapleader=","
let mapleader=" "

" Vim compatiblity and filetype handling
set nocompatible
set fileformat=unix
syntax on
filetype on
filetype plugin on
filetype indent on

" http://items.sjbach.com/319/configuring-vim-right
set hidden
set history=1000
set wildmenu
set title
runtime macros/matchit.vim

" intelligent backspace
set backspace=indent,eol,start

" backspace and cursor keys wrap to previous/next line
"set whichwrap+=<,>,h,l,[,]

" highlight search terms
set hlsearch
set incsearch
nnoremap <silent> <leader><leader> :nohlsearch<CR>

" turn off the bell
"set visualbell

" set text sizes for source code editing
set softtabstop=2
set tabstop=2
set shiftwidth=2
set textwidth=0 " unlimited

" set text behavior
set nolist
set number
set autoindent
set showmatch
set showmode
set nowrap
set expandtab

" set better cursor context
set scrolloff=3
set cursorline
set nocursorcolumn

" set color scheme
if has('gui_running')
  colors murphy
else
  colors darkZ
endif

" setup spell checker
set spell spl=en_us " Select language
set nospell " Turn it off at start

" Removes trailing spaces
" http://www.bestofvim.com/tip/trailing-whitespace/
function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction

nnoremap <silent> <Leader>tws :call TrimWhiteSpace()<CR>

autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()

" set hotkeys for plugins
nnoremap <silent> <F3> :TagbarToggle<CR>
nnoremap <silent> <F4> :YRShow<CR>
nnoremap <silent> <F5> :BufExplorer<CR>
nnoremap <silent> <F6> :e %:p:h<CR>
nnoremap <silent> <F7> :NERDTreeToggle<CR>
nnoremap <silent> <F8> :UndotreeToggle<CR>

" ctrlp
nnoremap <silent> <leader>cp :CtrlP<cr>
nnoremap <silent> <leader>cpb :CtrlPBuffer<cr>
nnoremap <silent> <leader>cpm :CtrlPMixed<cr>

" tabular
nnoremap <leader><bar> :Tabularize /\|/<CR>
nnoremap <leader>> :Tabularize /=>/<CR>
nnoremap <leader>= :Tabularize /=/<CR>
nnoremap <leader>: :Tabularize /:\zs/<CR>

" stuff
nnoremap <silent> <leader>em :e %:p:h<cr>
nnoremap <silent> <leader>ev :tabnew $MYVIMRC<cr>
nnoremap <silent> <leader>sv :source $MYVIMRC<cr>

" other command shortcuts
noremap Y y$
" force write a file as sudo
ca w!! w !sudo tee "%"

" movement between splits
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l

" setup status line
if has("win32")
  set statusline=%F%m%r%h%w\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]\ [FORMAT=%{&ff}]
else
  set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]\ [FORMAT=%{&ff}]
  "set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ [POS=%04l,%04v][%p%%]\ [LEN=%L]\ [FORMAT=%{&ff}]
end
set laststatus=2

" setup tab key for navigating between buffers
"set autochdir
map <Tab> <C-W>W:cd %:p:h<CR>:<CR>

" setup the NERD_tree plugin
let NERDChristmasTree=1
let NERDTreeAutoCenter=1
let NERDTreeCaseSensitiveSort=0
let NERDTreeChDirMode=1
let NERDTreeHighlightCursorline=1
let NERDTreeQuitOnOpen=0

" enable and configure persistent undo
if has("persistent_undo")
  set undodir='~/.undodir/'
  set undofile
endif

" settings for various file types
au BufRead,BufNewFile {*.R} set ft=R
au BufRead,BufNewFile *.md set filetype=markdown

" settings for Ruby files
au BufRead,BufNewFile {Capfile,.caprc} set ft=ruby
au BufRead,BufNewFile Gemfile set ft=ruby
au BufRead,BufNewFile Rakefile set ft=ruby
au BufRead,BufNewFile Thorfile set ft=ruby
au BufRead,BufNewFile config.ru set ft=ruby
au BufRead,BufNewFile {.irbrc,irb_tempfile*} set ft=ruby

" settings for Go files
" https://github.com/fatih/vim-go
au BufRead,BufNewFile *.go set filetype=go
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

" settings for text files
autocmd BufNewFile,BufReadPre *.txt set textwidth=80
autocmd BufNewFile,BufReadPre *.txt set spell spl=en_us
autocmd BufNewFile,BufReadPre *.txt set number
autocmd BufNewFile,BufReadPre *.txt let g:autoclose_on=1

" settings for C++ files
autocmd BufNewFile,BufReadPre *.{h,cpp} set softtabstop=2
autocmd BufNewFile,BufReadPre *.{h,cpp} set tabstop=2
autocmd BufNewFile,BufReadPre *.{h,cpp} set shiftwidth=2

" Windows-like clipboard behavior
" http://superuser.com/questions/10588/how-to-make-cut-copy-paste-in-gvim-on-ubuntu-work-with-ctrlx-ctrlc-ctrlv
if has('gui_running')
  " CTRL-X and SHIFT-Del are Cut
  vnoremap <C-X> "+x
  vnoremap <S-Del> "+x
  " CTRL-C and CTRL-Insert are Copy
  vnoremap <C-C> "+y
  vnoremap <C-Insert> "+y
  " CTRL-V and SHIFT-Insert are Paste
  map <C-V>		"+gP
  map <S-Insert>		"+gP
  cmap <C-V>		<C-R>+
  cmap <S-Insert>		<C-R>+
  " Use CTRL-Q to do what CTRL-V used to do
  noremap <C-Q>		<C-V>
endif
