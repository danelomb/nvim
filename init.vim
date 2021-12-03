filetype off


call plug#begin(stdpath('data') . '/plugged')


Plug 'vim-scripts/burnttoast256'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'bfrg/vim-cpp-modern'
Plug 'tpope/vim-surround'
Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'godlygeek/tabular'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'kien/ctrlp.vim'
Plug 'justinmk/vim-sneak'
Plug 'preservim/nerdtree'
Plug 'webastien/vim-ctags'

call plug#end()

filetype plugin indent on    " required

syntax on
set autoread
set encoding=utf-8
let g:EasyMotion_smartcase = 1
set guioptions-=T
set guifont=Consolas:h14
let mapleader = ","
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
set relativenumber
set background=dark
set splitbelow
set splitright
set nohlsearch
let g:NERDDefaultAlign = 'left'
let g:NERDToggleCheckAllLines = 1
let g:NERDCreateDefaultMappings = 1
colo elflord

vnoremap <C-C> "+y
map <leader>a :cd %:p:h 
map z/ <Plug>(incsearch-easymotion-/)
map s <Plug>(easymotion-overwin-f)
vmap s <Plug>(easymotion-bd-f)
map <leader>q :q<CR>
map <leader>w :w<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
map f <Plug>Sneak_s
map F <Plug>Sneak_S
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
map <C-n> :NERDTreeToggle<CR>
nnoremap <silent> <CR> :nohlsearch<CR><CR>
map <leader>f gg=G<C-o><C-o>
map <leader>cc <plug>NERDCommenterToggle<CR>
map J 10j
map K 10k
inoremap {<CR> {<CR>}<Esc>ko
map <leader>d gg=G<C-o><C-o>
nnoremap <leader>m :CtrlPTag<cr>

function! s:config_easyfuzzymotion(...) abort
	return extend(copy({
				\   'converters': [incsearch#config#fuzzy#converter()],
				\   'modules': [incsearch#config#easymotion#module()],
				\   'keymap': {"\<CR>": '<Over>(easymotion)'},
				\   'is_expr': 0,
				\   'is_stay': 1
				\ }), get(a:, 1, {}))
endfunction


noremap <silent><expr> / incsearch#go(<SID>config_easyfuzzymotion()) 

function BuildProject()
	"save the current working directory so we can come back
	let l:starting_directory = getcwd()

	"get the directory of the currently focused file
	let l:curr_directory = expand('%:p:h')
	"move to the current file
	execute "cd " . l:curr_directory

	while 1
		"check if build.bat exists in the current directory
		if filereadable("build.bat")
			"run make and exit
			make
			break
		elseif l:curr_directory ==# "/" || l:curr_directory =~# '^[^/]..$'
			"if we've hit the top level directory, break out
			break
		else
			"move up a directory
			cd ..
			let l:curr_directory = getcwd()
		endif
	endwhile

	"reset directory
	execute "cd " . l:starting_directory
endfunction

nmap <leader>b :call BuildProject()
