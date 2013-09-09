syntax enable
syntax on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent 
set cindent
set nu

let &errorformat="%f:%l:%c: %t%*[^:]:%m,%f:%l: %t%*[^:]:%m,".&errorformat 

if &term=="xterm"
set t_Co=8
             set t_Sb=^[[4%dm
set t_Sf=^[[3%dm
endif

behave mswin 
"set list 
"set listchars=tab:>-,trail:- 
set laststatus=2 "显示状态栏(默认值为1, 无法显示状态栏) 
set statusline= 
set statusline+=%2*%-3.3n%0*\ " buffer number 
set statusline+=%f\ " file name 
set statusline+=%h%1*%m%r%w%0* " flag 
set statusline+=[ 
if v:version >= 600 
    set statusline+=%{strlen(&ft)?&ft:'none'}, " filetype 
    set statusline+=%{&fileencoding}, " encoding 
endif 
set statusline+=%{&fileformat}] " file format 
set statusline+=%= " right align 
"set statusline+=%2*0x%-8B\ " current char 
set statusline+=0x%-8B\ " current char 
set statusline+=%-14.(%l,%c%V%)\ %<%P " offset 
if filereadable(expand("$VIM/vimfiles/plugin/vimbuddy.vim")) 
    set statusline+=\ %{VimBuddy()} " vim buddy 
endif 

set clipboard+=unnamed 
set completeopt=preview,menu
"autocmd InsertLeave * se nocul  " 用浅色高亮当前行  
"autocmd InsertEnter * se cul    " 用浅色高亮当前行  
set ruler           " 显示标尺
set cursorline 
"set cursorcolumn
set showcmd
set scrolloff=3

" 映射全选+复制 ctrl+a
map <C-A> ggVG
map! <C-A> <Esc>ggVG
map <F12> gg=G
" 选中状态下 Ctrl+c 复制
vmap <C-c> "+y

set hlsearch
set incsearch

"C，C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
"        exec "!g++ % -o %<"
		set makeprg=LANGUAGE=C\ gcc\ -Wall\ %\ -o\ %<
		exec "make"
"        exec "! ./%<"
    elseif &filetype == 'cpp'
"        exec "!g++ % -o %<"
		set makeprg=LANGUAGE=C\ g++\ -Wall\ %\ -o\ %<
		exec "make"
"        exec "! ./%<"
    elseif &filetype == 'java' 
        exec "!javac %" 
        exec "!java %<"
    elseif &filetype == 'sh'
        :!./%
    endif
	execute "silent make"
	set makeprg=make
	execute "vertical cw 75"
	execute "normal :"
endfunc

"状态行颜色 
"highlight StatusLine guifg=SlateBlue guibg=Yellow 
"highlight StatusLineNC guifg=Gray guibg=White 

if has("gui_running")
   colorscheme desert2
   set guifont=DejaVu\ Sans\ Mono\ 10
   :map <silent> <C-S> :if expand("%") == ""<CR>:browse confirm w<CR>:else<CR>:confirm w<CR>:endif<CR> 
   noremap <M-1> 1gt 
   noremap <M-2> 2gt 
   noremap <M-3> 3gt 
   noremap <M-4> 4gt 
   noremap <M-5> 5gt 
   noremap <M-6> 6gt 
   noremap <M-7> 7gt 
   noremap <M-8> 8gt 
   noremap <M-9> 9gt 
   noremap <M-0> 10gt 
   noremap <C-TAB> gt 
   noremap <C-F4> <ESC>:bd<CR> 
   noremap qt <ESC>:bd<CR>
else
   colorscheme grb256
endif

set guioptions-=T
set formatoptions+=mM 

au GUIEnter * silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
set wildmode=list:full
set wildmenu
set iskeyword+=_,$,@,%,#,-
