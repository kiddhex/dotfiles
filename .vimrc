execute pathogen#infect()
execute pathogen#helptags()

syntax enable

" Automatic time-based theme switching
let current_hour = strftime("%H")

" If it's between 7 AM (07) and 7 PM (19), use Light mode
if current_hour >= 7 && current_hour < 19
    set background=light
else
    set background=dark
endif

let g:solarized_termcolors=256
colorscheme solarized

:set number

set tabstop=2 
set shiftwidth=2 
set expandtab 
