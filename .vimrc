execute pathogen#infect()
syntax on
filetype plugin indent on
set softtabstop=2
set sw=2 et
set autoindent
set smartindent
"set background=dark

highlight LiteralTabs ctermbg=darkgreen guibg=darkgreen
match LiteralTabs /\s\  /
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/

""function! Folding()
"  :au BufWinLeave *.* mkview
"  "  :au BufWinEnter *.* silent loadview
"  "  :set foldmethod=marker
"  "  :set commentstring=\ #\ %s
"  "  :set foldlevel=0
"  "endfunction

map <F2> :set background=dark<CR>
map <F3> :set background=light<CR>
map <F12> :execute Folding()<CR>
