" ================
" 插件
" ================
call plug#begin('~/.vim/plugged')
"Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)

"文件树
Plug 'junegunn/fzf', { 'dir': '~/.nvim-fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"主题
Plug 'NLKNguyen/papercolor-theme'
Plug 'phanviet/vim-monokai-pro'

"C高亮
Plug 'NLKNguyen/c-syntax.vim'

"VIM 中文help
Plug 'yianwillis/vimcdoc'

"括号自动补全
Plug 'jiangmiao/auto-pairs'

"清除行尾无效空格
Plug 'ntpeters/vim-better-whitespace'
Plug 'majutsushi/tagbar'

"Git
Plug 'tpope/vim-fugitive'

"左边实现显示git变动
Plug 'airblade/vim-gitgutter'

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
set hlsearch                    " 高亮搜索
set incsearch                   " 键入搜索


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
noremap <Leader>q :q<CR>        " 关闭当前窗口
noremap <Leader>Q :qa!<CR>      " 关闭所有窗口

" 窗口切换
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" terminal
tnoremap <esc> <C-\><C-N>

" =================
" 专有配置
" =================

"FZF
nmap <silent> <F8> :FZF .<enter>

"tagbar
nmap <silent> <F2> :TagbarToggle<CR>
let g:tagbar_autoclose = 0
let g:tagbar_autofocus = 1
let g:tagbar_iconchars = ['+', '-']

"Git
let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']

nmap <Leader>gm <Plug>(git-messenger)

"Cscope

if has("cscope")
    set csprg=/usr/bin/cscope
    set cscopequickfix=s-,c-,d-,i-,t-,e-,a-
		set csto=0
		set cst
		" add any database in current directory
		if filereadable("cscope.out")
		    silent cs add cscope.out
		" else add database pointed to by environment
		elseif $CSCOPE_DB != ""
		    silent cs add $CSCOPE_DB
		endif

  map <C-_> :cstag <C-R>=expand("<cword>")<CR><CR>
  map g<C-]> :cs find c <C-R>=expand("<cword>")<CR><CR>
	map g<C-\> :cs find s <C-R>=expand("<cword>")<CR><CR>
  "Find this C symbol
  nmap <Leader>s :cs find s <C-R>=expand("<cword>")<CR><CR>
  "Find this definition
	nmap <Leader>g :cs find g <C-R>=expand("<cword>")<CR><CR>
  "Find functions calling this function
	nmap <Leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>
  "Find this text string
	nmap <Leader>t :cs find t <C-R>=expand("<cword>")<CR><CR>
  "Find this egrep pattern
	nmap <Leader>e :cs find e <C-R>=expand("<cword>")<CR><CR>
  "Find this file
	nmap <Leader>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
  "Find files #including this file
	nmap <Leader>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  "Find functions called by this function
	nmap <Leader>d :cs find d <C-R>=expand("<cword>")<CR><CR>
	nmap <Leader>a :cs find a <C-R>=expand("<cword>")<CR><CR>
endif
