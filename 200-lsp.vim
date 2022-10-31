if empty(globpath(&rtp, 'autoload/lsp.vim'))
  finish
endif

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> <f2> <plug>(lsp-rename)
  inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
command! LspDebug let lsp_log_verbose=1 | let lsp_log_file = expand('~/lsp.log')

"man.vim
map <leader>k <Plug>(Man)

" fzf.vim
" Ctrl+pでファイル検索を開く
" git管理されていれば:GFiles、そうでなければ:Filesを実行する
fun! FzfOmniFiles()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GFiles
  endif
endfun
nnoremap <C-p> :call FzfOmniFiles()<CR>

" Ctrl+gで文字列検索を開く
" <S-?>でプレビューを表示/非表示する
command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\ 'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
\ <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 3..'}, 'up:60%')
\ : fzf#vim#with_preview({'options': '--exact --delimiter : --nth 3..'}, 'right:50%:hidden', '?'),
\ <bang>0)
nnoremap <C-g> :Rg<CR>

" frでカーソル位置の単語をファイル検索する
nnoremap fr vawy:Rg <C-R>"<CR>
" frで選択した単語をファイル検索する
xnoremap fr y:Rg <C-R>"<CR>

" fbでバッファ検索を開く
nnoremap fb :Buffers<CR>
" fpでバッファの中で1つ前に開いたファイルを開く
nnoremap fp :Buffers<CR><CR>
" flで開いているファイルの文字列検索を開く
nnoremap fl :BLines<CR>
" fmでマーク検索を開く
nnoremap fm :Marks<CR>
" fhでファイル閲覧履歴検索を開く
nnoremap fh :History<CR>
" fcでコミット履歴検索を開く
nnoremap fc :Commits<CR>

"ddc settings
" Customize global settings
 " Use around source.
 " https://github.com/Shougo/ddc-around
call ddc#custom#patch_global('sources', ['around'])
 " Use matcher_head and sorter_rank.
 " https://github.com/Shougo/ddc-matcher_head
 " https://github.com/Shougo/ddc-sorter_rank
call ddc#custom#patch_global('sourceOptions', {
       \ '_': {
       \   'matchers': ['matcher_head'],
       \   'sorters': ['sorter_rank']},
       \ })

  " Change source options
 call ddc#custom#patch_global('sourceOptions', {
       \ 'around': {'mark': 'A'},
       \ })
 call ddc#custom#patch_global('sourceParams', {
       \ 'around': {'maxSize': 500},
       \ })

  " Customize settings on a filetype
 call ddc#custom#patch_filetype(['c', 'cpp'], 'sources', ['around', 'clangd'])
 call ddc#custom#patch_filetype(['c', 'cpp'], 'sourceOptions', {
       \ 'clangd': {'mark': 'C'},
       \ })
 call ddc#custom#patch_filetype('markdown', 'sourceParams', {
       \ 'around': {'maxSize': 100},
       \ })

 " Mappings

 "<TAB>: completion.
inoremap <silent><expr> <TAB>
\ ddc#map#pum_visible() ? '<C-n>' :
\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
\ '<TAB>' : ddc#map#manual_complete()

 " <S-TAB>: completion back.
inoremap <expr><S-TAB>  ddc#map#pum_visible() ? '<C-p>' : '<C-h>'

 " Use ddc.
call ddc#enable()

" MAP
map f <Plug>(easymotion-fl)
map t <Plug>(easymotion-tl)
map F <Plug>(easymotion-Fl)
map T <Plug>(easymotion-Tl)
nnoremap <C-n> :Fern . -reveal=% -drawer -toggle -width=30<CR>
" nnoremap re :source ~/.vimrc<CR>  
nnoremap 42 :Stdheader<CR>  
"colorscheme
" colorscheme codedark
colorscheme iceberg
" colorscheme deep-space

"inoremap <silent> jj <ESC>
let g:airline#extensions#tabline#enabled = 1
" leaderをスペースへ設定
let mapleader = "\<Space>"
" vim関連map
nnoremap <silent> <Leader>vc :new ~/.vim/_config/200-lsp.vim<CR>   
nnoremap <silent> <Leader>vm :new ~/.vim/_config/map.vim<CR>   
nnoremap <silent> <Leader>vr :new ~/.vimrc<CR>
" nnoremap <silent> <Leader>bk :highlight Normal ctermbg=none<CR>
nnoremap <silent> <Leader>rr :source ~/.vimrc<CR>  

nnoremap <silent> <Leader>term :set autochdir<CR>:bo terminal++rows=10<CR> 
"Undoの永続化
if has('persistent_undo')
	let undo_path = expand('~/.vim/undo')
	exe 'set undodir=' .. undo_path
	set undofile
endif

"asyncomplete.vim
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

"parmsetting
" let g:airline_theme = 'iceberg'
" let g:airline_solarized_bg='dark'
" let g:airline_theme='deep_space'
let g:fern#renderer = 'nerdfont'
" let g:fern#renderer = 'iceberg'
let g:user42 = 'tyamauch'
let g:mail42 = 'tyamauch@student.42.fr'
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 0
let g:asyncomplete_popup_delay = 50
let g:lsp_text_edit_enabled = 0
let g:c_formatter_42_set_equalprg=1
" let g:c_formatter_42_format_on_save=1
let g:c_formatter_42_format_on_save=0
" let g:glyph_palette#palette=0

" 公式リポジトリを参考にキーマップを追加
function! s:fern_settings() abort
  nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
  nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
  nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
  nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
endfunction

augroup fern-settings
  autocmd!
  autocmd FileType fern call s:fern_settings()
augroup END

" アイコンに色をつける
augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END
