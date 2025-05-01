" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Dec 17
"
" To use it, copy it to
"	       for Unix:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"	 for MS-Windows:  $VIM\_vimrc
"	      for Haiku:  ~/config/settings/vim/vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

"if &t_Co > 2 || has("gui_running")
"  " Switch on highlighting the last used search pattern.
"  set hlsearch
"endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"--- clipboard settings ---
set clipboard=unnamedplus   " クリップボードを有効にする
"--------------------------

"--- indent settings ---
set shiftwidth=4      " インデントを4文字分にする
set smarttab          " 行の先頭で<Tab>キーを入力するとインデントを挿入する
set expandtab         " タブの代わりに半角スペースを使用
set tabstop=8         " タブを8文字分にする
set softtabstop=4     " <Tab>キー入力時の文字数をtsと同じにする
set smartindent       " 新しい行追加時に自動でインデントを追加
" set cinoptions+=L0    " 行継続時にインデントを追加しない
"-----------------------

"--- settings based on filetype ---
augroup python_settings
    autocmd!
    autocmd FileType python setlocal tabstop=4
    autocmd FileType python setlocal shiftwidth=4
    autocmd FileType python setlocal expandtab
    autocmd FileType python setlocal autoindent
    autocmd FileType python setlocal nosmartindent
augroup END
"----------------------------------

"--- commandline settings ---
set wildmenu          " コマンドラインでTAB補完時に候補メニューを表示
set wildignorecase    " コマンドラインでTAB補完時に大文字・小文字を区別しない
"----------------------------

"--- search settings ---
set hlsearch          " 文字列検索のハイライト
nmap <silent> <Esc><Esc> :<C-u>nohlsearch<CR><Esc> " 文字列検索のハイライトオフ
set ignorecase        " 文字列検索で大文字・小文字を区別しない
set smartcase         " 文字列検索で大文字を含んでいたらignorecaseを上書きし、大文字・小文字を区別する
set incsearch         " インクリメンタルサーチ
"-----------------------

"--- file settings ---
set noswapfile        " スワップファイル(.swp)を生成しない
set nobackup          " バックアップファイル(~)を生成しない
set noundofile        " undoファイル(.un~)を生成しない
set encoding=utf-8    " Vim内部で使われる文字エンコーディングにutf-8にする
"---------------------

"--- language settings ---
set helplang=ja,en
"-------------------------

"--- display settings ---
set number            " 画面左端に行番号を表示
set signcolumn=yes    " 画面左端にサイン列を常に表示
set laststatus=2      " 画面最下部に常にステータスラインを表示
"set cmdheight=2       " 画面最下部(ステータス行より下)のメッセージ表示欄を2行にする
set showtabline=2     " タブ毎に常にタブラインを表示
"set statusline=%F%m%h%w\ %<[ENC=%{&fenc!=''?&fenc:&enc}]\ [FMT=%{&ff}]\ [TYPE=%Y]\ %=[CODE=0x%02B]\ [POS=%l/%L(%02v)]   " ステータスラインに表示する内容
"------------------------

"--- map settings in insert mode---
inoremap jj <Esc>
" 入力モードでのカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
"----------------------------------

"--- map settings in normal mode---
nnoremap <leader>sv :source $MYVIMRC<CR>
"----------------------------------

"--- mouse settings ---
set mouse=a           " マウス操作を有効にする
"----------------------

"--- visual block settings ---
set virtualedit=block " 矩形選択時に仮想編集を有効化
"-----------------------------

"--- custom commands ---
command! Bterm below term
"-----------------------

"--- vim-plug list ---
call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'} " LSPの導入
Plug 'vim-jp/vimdoc-ja'         " helpの日本語化
Plug 'itchyny/lightline.vim'    " ステータスライン表示のリッチ化
Plug 'lambdalisue/fern.vim'     " ファイルエクスプローラー
Plug 'lambdalisue/nerdfont.vim' " Nerd Fontsの導入
Plug 'lambdalisue/fern-renderer-nerdfont.vim'   " ファイルエクスプローラーにアイコンを表示
Plug 'lambdalisue/fern-git-status.vim'  "gitステータスの表示
Plug 'airblade/vim-gitgutter'   " ファイル左端にgit差分情報の表示
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }     " fazzyfinder
Plug 'junegunn/fzf.vim'         " fazzyfinder
Plug 'tpope/vim-commentary'     " コメントアウト
Plug 'godlygeek/tabular'        " vim-markdownに必要
Plug 'preservim/vim-markdown'   " Markdown用プラグイン
call plug#end()
filetype plugin indent on
"-----------------------------

"--- Settings for coc.nvim (exmaple) ---
" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
"-----------------------------

"--- Settings for coc.nvim (custom) ---
" Enterキーでサジェスチョンを選択せずに改行を行う
" inoremap <silent><expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
"---------------------------------------

"--- Settings for fern ---
let g:fern#default_hidden=1 " 隠しファイルを表示する
let g:fern#renderer='nerdfont'
let g:fern#renderer#nerdfont#indent_markers=1
"-------------------------

"--- Seetings for gitgutter ---
set updatetime=100 " 更新時間を100msに設定

let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'
"------------------------------

"--- Settings for vim-markdown ---
"let g:vim_markdown_folding_disabled = 1
"---------------------------------
