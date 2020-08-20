set nocompatible
syntax enable
set t_Co=256
set cursorline
hi CursorLine cterm=none ctermbg=239
set number
set tabstop=4 
set softtabstop=4
set mouse=a
if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
end
