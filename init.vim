" =================
" 插件
" =================
call plug#begin('~/.vim/plugged')
"Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
Plug 'akinsho/bufferline.nvim'
Plug 'kyazdani42/nvim-tree.lua'

"文件树
Plug 'junegunn/fzf', { 'dir': '~/.nvim-fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"主题
Plug 'NLKNguyen/papercolor-theme'

"C高亮
Plug 'NLKNguyen/c-syntax.vim'
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
set background=dark
colorscheme PaperColor
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
let g:airline_theme='papercolor'

" =================
" 通用配置
" =================
set clipboard+=unnamed          " 启用共享粘贴板
set number                      " 显示行号
set relativenumber              " 显示相对行号（这个非常重要，慢慢体会）
set autoindent                  " 自动缩进
set smartindent                 " 智能缩进
set tabstop=2                   " 设置 tab 制表符所占宽度为 4
set softtabstop=2               " 设置按 tab 时缩进的宽度为 4
set shiftwidth=2                " 设置自动缩进宽度为 4
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
"Nvimtree
"If 0, do not show the icons for one of 'git' 'folder' and 'files'
"1 by default, notice that if 'files' is 1, it will only display
"if nvim-web-devicons is installed and on your runtimepath.
"if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
"but this will not work when you set indent_markers (because of UI conflict)

" default will show icon by default if no icon is provided
" default shows no icon by default
let g:nvim_tree_side = 'left'
let g:nvim_tree_auto_open = 1
let g:nvim_tree_ignore = [ '.git', '.vscode', '.cache', '.clangd' ] "empty by default
let g:nvim_tree_width = 40
let g:nvim_tree_auto_open = 1
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ }

nmap <silent> <F8> :NvimTreeToggle<CR>
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
" NvimTreeOpen, NvimTreeClose and NvimTreeFocus are also available if you need them


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

"Buffer
" In your init.lua or init.vim
lua << EOF
require("bufferline").setup{
  offsets = {
  {
    filetype = "NvimTree",
    text = "File Explorer",
    highlight = "Directory",
    text_align = "left"
  }
  }
}
EOF

" These commands will navigate through buffers in order regardless of which mode you are using
" e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
nnoremap <silent> <leader>bn :BufferLineCycleNext<CR>
nnoremap <silent> <leader>bp :BufferLineCyclePrev<CR>
nnoremap <silent> <leader>bd :bd<CR>
nnoremap <silent> <leader>br :BufferLineCloseRight<CR>

" These commands will move the current buffer backwards or forwards in the bufferline
" nnoremap <silent><mymap> :BufferLineMoveNext<CR>
" nnoremap <silent><mymap> :BufferLineMovePrev<CR>

" These commands will sort buffers by directory, language, or a custom criteria
" nnoremap <silent>be :BufferLineSortByExtension<CR>
nnoremap <silent> <leader>bs :BufferLineSortByDirectory<CR>
" nnoremap <silent><mymap> :lua require'bufferline'.sort_buffers_by(function (buf_a, buf_b) return buf_a.id < buf_b.id end)<CR>



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
