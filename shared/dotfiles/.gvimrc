"---- _gvimrc

" set the screen size
set lines=60
set columns=160

" set the font
" use ':set gfn?' in gVim to see the current font
if has("mac")
  set guifont=Inconsolata:h18.00
elseif has("unix")
  set guifont=Inconsolata\ Medium\ 12
  set lines=60
  set columns=180
elseif has("win32")
  set guifont=Lucida_Console:h12
else
  set guifont=Inconsolata:h18.00
endif

" set hotkeys for tab navigation
map <C-t> :tabnew<CR>
map <C-left> :tabp<CR>
map <C-right> :tabn<CR>

" change to my most common working directory
if has("mac")
	:silent cd $HOME/Projects
elseif has("unix")
	:silent cd $HOME/Projects
elseif has("win32")
	:silent cd $HOME/Projects
endif

set vb t_vb=
