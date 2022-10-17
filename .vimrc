set tabstop=4 
set number 
set relativenumber
set wildmenu
set clipboard=unnamed,autoselect

call plug#begin() 
"42header
Plug '42Paris/42header'

"42formatter
Plug 'cacharle/c_formatter_42.vim'

" Template を作成 ex. :Template main 
Plug 'mattn/vim-sonictemplate' 

" Git操作
Plug 'tpope/vim-fugitive'

" コメントアウト便利
Plug 'tpope/vim-commentary'

" keyword移動
Plug 'andymass/vim-matchup' 

" Filer 
Plug 'lambdalisue/fern.vim' 
 Plug 'lambdalisue/fern-hijack.vim'
 Plug 'yuki-yano/fern-preview.vim'

" Coler Term 
Plug 'tomasiser/vim-code-dark' 
Plug 'lambdalisue/glyph-palette.vim' 
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lambdalisue/glyph-palette.vim'

" File explorer 
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } 
Plug 'junegunn/fzf.vim' 

"easy motion 
Plug 'easymotion/vim-easymotion' 

"ddc plug 
Plug 'Shougo/ddc.vim' 
Plug 'vim-denops/denops.vim' 
Plug 'Shougo/pum.vim' 
Plug 'Shougo/ddc-around' 
Plug 'LumaKernel/ddc-file' 
Plug 'Shougo/ddc-matcher_head' 
Plug 'Shougo/ddc-sorter_rank' 
Plug 'Shougo/ddc-converter_remove_overlap' 
Plug 'shun/ddc-vim-lsp' 

"lsp plug 
Plug 'prabirshrestha/vim-lsp' 
Plug 'mattn/vim-lsp-settings' 

"auto complete 
"Plug 'prabirshrestha/asyncomplete.vim' 
"Plug 'prabirshrestha/asyncomplete-lsp.vim' 

" detail settings
"Plug 'ajh17/vimcompletesme' 
Plug 'mattn/vim-lsp-icons' 
Plug 'hrsh7th/vim-vsnip' 
"Plug 'hrsh7th/vim-vsnip-integ' 
call plug#end()

" config
call map(sort(split(globpath(&runtimepath, '_config/*.vim'))), {->[execute('exec "so" v:val')]})
