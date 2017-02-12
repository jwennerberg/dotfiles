execute pathogen#infect()
syntax on
filetype plugin indent on
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set number
"set background=dark
"set cursorline

highlight LiteralTabs ctermbg=darkgreen guibg=darkgreen
match LiteralTabs /\s\  /
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/

au BufRead,BufNewFile Makefile* set noexpandtab
"autocmd FileType ruby,yaml setlocal expandtab autoindent shiftwidth=2 softtabstop=2

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
