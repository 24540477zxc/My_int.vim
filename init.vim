" =================
" 插件
" =================
call plug#begin('~/.vim/plugged')

"文件树
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'kristijanhusak/defx-git'
Plug 'kristijanhusak/defx-icons'
Plug 'junegunn/fzf', { 'dir': '~/.nvim-fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"主题
Plug 'NLKNguyen/papercolor-theme'
"C高亮
Plug 'NLKNguyen/c-syntax.vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'jackguo380/vim-lsp-cxx-highlight'
"VIM 中文help
Plug 'yianwillis/vimcdoc'
"括号自动补全                           
Plug 'jiangmiao/auto-pairs'
"清除行尾无效空格
Plug 'ntpeters/vim-better-whitespace'
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install', 'for': 'markdown'  }
Plug 'majutsushi/tagbar'
"Git
Plug 'tpope/vim-fugitive'
"左边实现显示git变动
Plug 'airblade/vim-gitgutter'
"coc 依赖Nodejs && yarn
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install() }, 'branch': 'release' }

call plug#end()


" =================
" 主题
" =================
"Color options
if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif
set background=dark
colorscheme PaperColor
let g:airline_theme='papercolor'
let g:PaperColor_Theme_Options = {
  \   'language': {
  \     'python': {
  \       'highlight_builtins' : 1
  \     },
  \     'cpp': {
  \       'highlight_standard_library': 1
  \     },
  \     'c': {
  \       'highlight_builtins' : 1
  \     }
  \   }
  \ }

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1        " 启用powerline样式字体

" =================
" 通用配置
" =================
set clipboard+=unnamed          " 启用共享粘贴板
set number                      " 显示行号
set relativenumber              " 显示相对行号（这个非常重要，慢慢体会）
set autoindent                  " 自动缩进
set smartindent                 " 智能缩进
set tabstop=4                   " 设置 tab 制表符所占宽度为 4
set softtabstop=4               " 设置按 tab 时缩进的宽度为 4
set shiftwidth=4                " 设置自动缩进宽度为 4
set expandtab                   " 缩进时将 tab 制表符转换为空格
set nowrap                      " 不自动换行
set cursorcolumn                " 高亮当前列
set cursorline                  " 高亮当前行
set ruler                       " 显示当前行号及列号
set cindent                     " C 缩进
set showmatch                   " 高亮显示匹配的括号
set nofoldenable                " 取消自动折叠

" 打开自动定位到最后编辑的位置, 需要确认 .viminfo 当前用户可写
if has("autocmd")
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


" ==================
" Mapping 快捷键
" =================
let mapleader = ","
let g:mapleader = ","

"Save
noremap <C-S> :w<CR>

" easier moving between tabs
map <Leader>tp <esc>:tabprevious<CR>
map <Leader>tn <esc>:tabnext<CR>

" Quick quit command
noremap <Leader>e :q<CR>        " 关闭当前窗口
noremap <Leader>E :qa!<CR>      " 关闭所有窗口

" 窗口切换
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h


" =================
" 专有配置
" =================
"coc
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
" 使用<TAB> 键触发COC补全
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
" 回车键确认COC选中的item
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  " if (index(['vim','help'], &filetype) >= 0)
  "   execute 'h '.expand('<cword>')
  " else
    call CocAction('doHover')
  " endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup coc
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <leader>ca  :<C-u>CocList diagnostics<cr>
" " Manage extensions
nnoremap <silent> <leader>ce  :<C-u>CocList extensions<cr>
" " Show commands
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
"
"
" COC Snippets
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? coc#_select_confirm() :
"       \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
"
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
let g:coc_snippet_next = '<tab>'


"Defx
call defx#custom#column('filename', {
    \ 'min_width': 20,
    \ 'max_width': 80,
    \ })

call defx#custom#column('icon', {
    \ 'directory_icon': '▸',
    \ 'opened_icon': '▾',
    \ 'root_icon': ' ',
    \ })

call defx#custom#column('git', 'indicators', {
    \ 'Modified'  : 'M',
    \ 'Staged'    : '✚',
    \ 'Untracked' : '✭',
    \ 'Renamed'   : '➜',
    \ 'Unmerged'  : '═',
    \ 'Ignored'   : '☒',
    \ 'Deleted'   : '✖',
    \ 'Unknown'   : '?'
    \ })

call defx#custom#column('git', 'column_length', 1)
call defx#custom#column('git', 'show_ignored', 0)
call defx#custom#column('git', 'raw_mode', 0)

let g:defx_icons_enable_syntax_highlight = 1
let g:defx_icons_column_length = 1

call defx#custom#option('_', {
    \ 'winwidth': 40,
    \ 'split': 'vertical',
    \ 'direction': 'topleft',
    \ 'show_ignored_files': 0,
    \ 'buffer_name': 'defxplorer',
    \ 'toggle': 1,
    \ 'resume': 1,
    \ 'auto_cd': 0,
    \ })

fu! s:isdir(dir) abort
    return !empty(a:dir) && (isdirectory(a:dir) ||
       \ (!empty($SYSTEMDRIVE) && isdirectory('/'.tolower($SYSTEMDRIVE[0]).a:dir)))
endfu

function! s:open_defx_if_directory()
  let l:full_path = expand(expand('%:p'))
  if isdirectory(l:full_path)
    Defx -auto-cd `expand('%:p')` -search=`expand('%:p')`
  endif
endfunction

" 只有defx窗口时自动关闭
autocmd BufEnter * if (!has('vim_starting') && winnr('$') == 1 && &filetype ==# 'defx') | quit | endif

autocmd BufWritePost * call defx#redraw()

"打开文件时自动选择文件
augroup user_plugin_defx
	  autocmd!
	  " Define defx window mappings
	  autocmd FileType defx call <SID>defx_mappings()
	  autocmd BufNewFile,BufRead * Defx `getcwd()` -no-focus
	  \ -search=`expand('%:p')`
	augroup END
	
	function! s:defx_mappings() abort
	  setlocal cursorline
	endfunction
	
	call defx#custom#option('_', {
	            \ 'winwidth': 40,
	            \ 'split': 'vertical',
	            \ 'direction': 'topleft',
	            \ })


" 打开目录时自动开启defx
" FIXME: 此处如果打开目录时使用 `floating` 窗口，将窗口无法取得焦点，所以指定`vertical`方式
" augroup ft_defx
"     autocmd!
"     autocmd VimEnter * sil! au! FileExplorer *
"     autocmd FileType defx DisableWhitespace
"     autocmd BufEnter * call s:open_defx_if_directory()
"     autocmd FileType defx call DefxSettings()
"     " au BufEnter * if s:isdir(expand('%')) | bd | call s:open_defx_if_directory() | endif
"     " au BufEnter * if s:isdir(expand('%')) | bd | exe 'Defx -split=vertical' | endif
" augroup end

function! DefxContextMenu() abort
  let l:actions = ['new_file', 'new_directory', 'rename', 'copy', 'move', 'paste', 'remove']
  let l:selection = confirm('Action?', "&New file\nNew &Folder\n&Rename\n&Copy\n&Move\n&Paste\n&Delete")
  silent exe 'redraw'

  return feedkeys(defx#do_action(l:actions[l:selection - 1]))
endfunction

function! DefxSettings() abort
  setl nonumber
  setl norelativenumber
  setl listchars=
  setl signcolumn=
  setl winfixwidth

" Define mappings
  ",+d open defx
  nnoremap <silent> <F8> :Defx<CR>
  nnoremap <silent><buffer>m :call DefxContextMenu()<CR>
  nnoremap <silent><buffer><expr> <CR> defx#is_directory() ? defx#do_action('open_directory') : defx#do_action('drop')
  nnoremap <silent><buffer><expr> o defx#is_directory() ? defx#do_action('open_or_close_tree') : defx#do_action('drop')
  nnoremap <silent><buffer><expr> vs defx#do_action('multi', [['drop', 'vsplit'], 'quit'])
  nnoremap <silent><buffer><expr> sp defx#do_action('multi', [['drop', 'split'], 'quit'])
  nnoremap <silent><buffer><expr> .. defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> c defx#do_action('copy')
  " nnoremap <silent><buffer><expr> m defx#do_action('move')
  nnoremap <silent><buffer><expr> p defx#do_action('paste')
  " nnoremap <silent><buffer><expr> s defx#do_action('open', 'botright vsplit')
  " nnoremap <silent><buffer><expr> E defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> P defx#do_action('open', 'pedit')
  nnoremap <silent><buffer><expr> l defx#do_action('open_or_close_tree')
  nnoremap <silent><buffer><expr> K defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> d defx#do_action('remove')
  nnoremap <silent><buffer><expr> r defx#do_action('rename')
  nnoremap <silent><buffer><expr> ! defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> h defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ; defx#do_action('repeat')
  nnoremap <silent><buffer><expr> ~ defx#do_action('cd')
  nnoremap <silent><buffer><expr> q defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> * defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-l> defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g> defx#do_action('print')
  nnoremap <silent><buffer><expr> cd defx#do_action('change_vim_cwd')
endfunction


"FZF
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-g> :GFiles<CR>

"markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_toc_autofit = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_autowrite = 1

"tagbar
nmap <silent> <F2> :TagbarToggle<CR>
let g:tagbar_autoclose = 0
let g:tagbar_autofocus = 1
let g:tagbar_iconchars = ['+', '-']
"set g:tagbar_ctags_bin = /usr/bin/ctags


"Git
let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']

nmap <Leader>gm <Plug>(git-messenger)
" Mapping	Description
" q	Close the popup window
" o	older. Back to older commit at the line
" O	Opposite to o. Forward to newer commit at the line
" d	Toggle diff hunks only related to current file in the commit
" D	Toggle all diff hunks in the commit
" ?	Show mappings help
