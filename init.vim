" ================
" 插件
" ================
call plug#begin('~/.vim/plugged')
"Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)

"cursorline
Plug 'yamatsum/nvim-cursorline'

"Fuzzy
Plug 'junegunn/fzf', { 'dir': '~/.nvim-fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

"主题
Plug 'tanvirtin/monokai.nvim'
Plug 'sainnhe/sonokai'
Plug 'sainnhe/gruvbox-material'
Plug 'sainnhe/everforest'

"C高亮
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

"VIM 中文help
Plug 'yianwillis/vimcdoc'

"括号自动补全
Plug 'jiangmiao/auto-pairs'

"清除行尾无效空格
Plug 'ntpeters/vim-better-whitespace'

Plug 'preservim/tagbar'

"注释
Plug 'numToStr/Comment.nvim'

"Git
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'

"左边实现显示git变动
Plug 'airblade/vim-gitgutter'

"nvim-vmp
Plug 'neovim/nvim-lspconfig'
Plug 'ojroques/nvim-lspfuzzy'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'glepnir/lspsaga.nvim'

"搜索
Plug 'kevinhwang91/nvim-hlslens'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

call plug#end()

" =================
" 主题
" =================
"Color options
set background=dark
 " Important!!
  if has('termguicolors')
    set termguicolors
  endif
  " The configuration options should be placed before `colorscheme sonokai`.
  let g:sonokai_style = 'atlantis'
  let g:sonokai_enable_italic = 0
  let g:sonokai_disable_italic_comment = 1

  let g:everforest_background  = 'mediam'
  colorscheme sonokai
" colorscheme monokai

let g:airline_theme = 'sonokai'
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
set mouse=nvi                   " 鼠标


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
"Comment
lua << EOF
require('Comment').setup()
EOF

"Search
noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
noremap * *<Cmd>lua require('hlslens').start()<CR>
noremap # #<Cmd>lua require('hlslens').start()<CR>
noremap g* g*<Cmd>lua require('hlslens').start()<CR>
noremap g# g#<Cmd>lua require('hlslens').start()<CR>

nnoremap <silent> <leader>s :noh<CR>

"FZF
nmap <silent> <F8> :FZF .<enter>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

"tagbar
nmap <silent> <F2> :TagbarToggle<CR>
let g:tagbar_autoclose = 0
let g:tagbar_autofocus = 1
let g:tagbar_iconchars = ['+', '-']

"Git

"Cscope
nmap <silent> <F5> :!cscope -Rbcq<CR>:cs reset<CR><CR>

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

  " map <C-_> :cstag <C-R>=expand("<cword>")<CR><CR>
  map g<C-]> :cs find c <C-R>=expand("<cword>")<CR><CR>
	map g<C-\> :cs find s <C-R>=expand("<cword>")<CR><CR>
  "Find this C symbol
  nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
  "Find this definition
	nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
  "Find functions calling this function
	nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
  "Find this text string
	nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
  "Find this egrep pattern
	nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
  "Find this file
	nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
  "Find files #including this file
	nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  "Find functions called by this function
	nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>a :cs find a <C-R>=expand("<cword>")<CR><CR>
endif

"nvim-cmp
set completeopt=menu,menuone,noselect

"nvim_lsp
nnoremap <silent><leader>ls <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent><leader>ll <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent><leader>lg <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent><leader>la <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent><leader>l; <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent><leader>l, <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      end,
    },
    mapping = {
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
        -- ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            select = true,
            behavior = cmp.ConfirmBehavior.Replace,
        }),
        -- ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end,
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  local nvim_lsp = require('lspconfig').clangd.setup {
      capabilities = capabilities
    }

  require('lspfuzzy').setup {}

  --nvim-treesitter
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
      enable = true,              -- false will disable the whole extension
      -- disable = { "c", "rust" },  -- list of language that will be disabled
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
  }

  -- local saga = require 'lspsaga'
  -- saga.init_lsp_saga()

  --Git
  require('gitsigns').setup{
    current_line_blame = true,
  }


EOF
