"Plugins...
call plug#begin()
" This is where we will add plugins to install
Plug 'morhetz/gruvbox'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
"Plug 'ctrlpvim/ctrlp.vim'
Plug 'udalov/kotlin-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()

colorscheme gruvbox
let g:airline_powerline_fonts = 1

"autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

set grepprg=rg\ --vimgrep\ --smart-case\ --follow
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

"Keymappings
let mapleader = ","
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>g :Rg<CR>
nnoremap <silent> <Leader>w <C-w>w
