" 去除VI一致性
"set nocompatible
"filetype off


"set rtp+=~/.vim/bundle/Vundle.vim

"call vundle#begin()
"	Plugin 'VundleVim/Vundle.vim'
"	Plugin 'tpope/vim-fugitive'
"	Plugin 'L9'
"	Plugin 'vim-latex/vim-latex'
"	Plugin 'rstacruz/sparkup',{'rtp':'vim/'}
"	Plugin 'xuhdev/vim-latex-live-preview'
"	Plugin 'junegunn/seou1256.vim'
"	Plugin 'junegunn/goyo.cim'
"	Plugin 'junegunn/limelight.vim'
"call vundle#end()

"filetype plugin indent on
"syntax enable

"---------------TexLive2019 Auto Refresh--------------------
"===========================================================
"set shellslash
"let g:tex_flavpr='latex'
"autocmd Filetype tex setl updatetime=1
"let g:livepreview_previewer='zathura'
"nmap <F12> <ESC>:LLPStartPreview<CR>
"imap <F12> <ESC>:LLPStartPreview<CR>
"autocmd filetype tex :LLPStartPreview
"let g:livepreview_engin = 'xelatex'
"let g:livepreview_cursorhold_recompile = 0


"----------------------- vim-plug---------------------------
"===========================================================
call plug#begin('~/.vim/plugged')

Plug 'honza/vim-snippets'
Plug 'sirver/ultisnips'
	let g:UltiSnipsExpandTrigger = '<tab>'
	let g:UltiSnipsJumpForwardTrigger = '<tab>'
	let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
Plug 'lervag/vimtex'
	let g:tex_flavor='latex'
	let g:vimtex_view_method='zathura'
	let g:vimtex_quickfix_mode=0
	let conceallevel=1
	let g:tex_conceal='abdmg'
Plug 'xuhdev/vim-latex-live-preview',{'for':'tex'}
	let g:livepreview_previewer='zathura'
	let g:livepreview_engine='xelatex'
	let g:livepreview_cursorhold_recompile=0
Plug 'Valloric/YouCompleteMe'
	let g:ycm_global_ycm_extra_conf='~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
	let g:ycm_collect_identifiers_from_tag_files=1
inoremap <C-l> <c-g>u<Esc>[s1z=']a<c-g>u
call plug#end()

"-------------------------实时编译--------------------------
"===========================================================
fu! TexLivePreview()
	if filewritable( bufname( '%' ) )
		silent update %
	endif
endfu
au CursorHoldI,CursorHold *.tex call TexLivePreview()


"--------------------------Snippet--------------------------
"===========================================================
"snippet today "Date"
"'date +%F'
"endsnippet
"snippet beg "begin{} / end{}" bA
"\begin{$1}
"$0
"\end{$1}
"endsnippet
let g:UltiSnipsSnippetDirectories=["UltiSnips","mysnippets"]


"------------------------------VIM配置------------------------------
"===================================================================
set nocompatible		"去掉vi一致性模式，避免以前版本的bug
				"和局限
set nu!				"显示行号
filetype on			"检测文件的类型
set history=1000		"记录历史的行数
syntax on			"语法高亮显示
set autoindent			"设置自动缩进对齐
set cindent			"针对C语言语法自动缩进
set smartindent			"依据上面的对齐格式，智能地选择对齐
				"方式，对于类似C语言编写上有用
"setlocal spell			"拼写检查
"set spelllang=en_us		"拼写检查语言
set ruler			"打开状态栏标尺
set magic			"设置魔术
"set foldnable			"折叠
let mapleader="<alt>"		"设置leader键
"set clipboard=			"剪贴板

"Function backup	"自动备份文件，以～为后缀
if has("vms")
	set nobackup
else
	set backup
endif
"End Function


"-------------------------编译器配置------------------------
"===========================================================

"""""""""""""""""""""""""C & JAVA"""""""""""""""""""""""""""
map <F5>:call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!./%<"
	elseif &filetype == 'cpp'
		exec "!g++ % -o %<"
		exec "!./%<"
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!java %<"
	elseif &filetype == 'tex'
		exec "LL"
	endif
endfunc


"----------------------You Complete Me----------------------
"===========================================================
"YouCompleteMe通过cm_global_ycm_extra_conf来获得补全规则，可
"以如下指定
"let g:ycm_global_ycm_extra_conf='~/.vim/plugged/YouComplet>
"	eMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
"让YouCompleteMe同时利用原来的ctags
"let g:ycm_collect_identifiers_from_tag_files=1
"配置操作：https://www.cnblogs.com/zhongcq/p/3630047.html


"---------------------------Leader--------------------------
"===========================================================
nmap <leader>c "+y
vmap <leader>c "+y
imap <leader>c "+y
