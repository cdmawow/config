"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700
set cursorline

" Enable filetype plugin
filetype plugin on
filetype indent on

let mapleader =","
let g:mapleader = ","

syntax on
set hlsearch 
set cursorline
set backspace=indent,eol,start
set splitright

" Platform
function! MySys()
    return "linux"
endfunction

function! SwitchToBuf(filename)
    "let fullfn = substitute(a:filename, "^\\~/", $HOME . "/", "")
    " find in current tab
    let bufwinnr = bufwinnr(a:filename)
    if bufwinnr != -1
        exec bufwinnr . "wincmd w"
        return
    else
        " find in each tab
        tabfirst
        let tab = 1
        while tab <= tabpagenr("$")
            let bufwinnr = bufwinnr(a:filename)
            if bufwinnr != -1
                exec "normal " . tab . "gt"
                exec bufwinnr . "wincmd w"
                return
            endif
            tabnext
            let tab = tab + 1
        endwhile
        " not exist, new tab
        exec "tabnew " . a:filename
    endif
endfunction

"Fast edit vimrc
if MySys() == 'linux'
    "Fast reloading of the .vimrc
    map <silent> <leader>ss :source ~/.vimrc<cr>
    "Fast editing of .vimrc
    map <silent> <leader>ee :call SwitchToBuf("~/.vimrc")<cr>
    "When .vimrc is edited, reload it
    autocmd! bufwritepost .vimrc source ~/.vimrc
elseif MySys() == 'windows'
    " Set helplang
    set helplang=cn
    "Fast reloading of the _vimrc
    map <silent> <leader>ss :source ~/_vimrc<cr>
    "Fast editing of _vimrc
    map <silent> <leader>ee :call SwitchToBuf("~/_vimrc")<cr>
    "When _vimrc is edited, reload it
    autocmd! bufwritepost _vimrc source ~/_vimrc
endif

" For windows version
if MySys() == 'windows'
    source $VIMRUNTIME/mswin.vim
    behave mswin
endif 


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable "Enable syntax hl

" Set font according to system
if MySys() == "mac"
  set gfn=Menlo:h14
  set shell=/bin/bash
elseif MySys() == "windows"
  set gfn=Bitstream\ Vera\ Sans\ Mono:h10
elseif MySys() == "linux"
  set gfn=Monospace\ 10
  set shell=/bin/bash
endif

if has("gui_running")
  set guioptions-=T
  set t_Co=256

  set background=dark
  colorscheme peaksea

  set nonu
else
  colorscheme zellner
  set background=dark
  "set nonu
  set nu
endif

set encoding=utf8
try
    lang en_US
catch
endtry

set ffs=unix,dos,mac "Default file types

""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2

" Format the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c


function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

set lbr
set tw=500

set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => windows
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=>ctags
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tags=tags;
set autochdir

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=>Cscope tool
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")
    set cscopetag   " 使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳来跳去
    " check cscope for definition of a symbol before checking ctags:
    " set to 1 if you want the reverse search order.
    set csto=1

    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add the database pointed to by environment variable
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    " show msg when any other cscope db added
    set cscopeverbose

"   nmap <C-/>s :cs find s <C-R>=expand("<cword>")<CR><CR>
"   nmap <C-/>g :cs find g <C-R>=expand("<cword>")<CR><CR>
"   nmap <C-/>c :cs find c <C-R>=expand("<cword>")<CR><CR>
"   nmap <C-/>t :cs find t <C-R>=expand("<cword>")<CR><CR>
"   nmap <C-/>e :cs find e <C-R>=expand("<cword>")<CR><CR>
"   nmap <C-/>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
"   nmap <C-/>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"   nmap <C-/>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=>TagList tool
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"map wm :TlistOpen<cr> 
"let Tlist_Hightlight_Tag_On_BufEnter = 1 
"let Tlist_Enable_Fold_Column = 0 
"let Tlist_Display_Prototype = 0 
"let Tlist_Compact_Format = 1 

let Tlist_Show_One_File=1
let Tlist_OnlyWindow=1
let Tlist_Use_Right_Window=0
let Tlist_Sort_Type='name'
let Tlist_Exit_OnlyWindow=1
let Tlist_Show_Menu=1
let Tlist_Max_Submenu_Items=10
let Tlist_Max_Tag_length=20
let Tlist_Use_SingleClick=0
let Tlist_Auto_Open=0
let Tlist_Close_On_Select=0
let Tlist_File_Fold_Auto_Close=1
let Tlist_GainFocus_On_ToggleOpen=0
let Tlist_Process_File_Always=1
let Tlist_WinHeight=10
let Tlist_WinWidth=18
let Tlist_Use_Horiz_Window=0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BufExplorer
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0       " Do not show default help.
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerSortBy='mru'        " Sort by most recently used.
let g:bufExplorerSplitRight=0        " Split left.
let g:bufExplorerSplitVertical=1     " Split vertically.
let g:bufExplorerSplitVertSize = 30  " Split width
let g:bufExplorerUseCurrentWindow=1  " Open in new window.


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=>winManager tool
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:winManagerWindowLayout='FileExplorer,BufExplorer|TagList'   " 这里可以设置为多个窗口, 如'FileExplorer|BufExplorer|TagList'
let g:persistentBehaviour=0              " 只剩一个窗口时, 退出vim.
let g:winManagerWidth=20
let g:defaultExplorer=1
nmap <silent> <leader>fir :FirstExplorerWindow<cr>
nmap <silent> <leader>bot :BottomExplorerWindow<cr>
nmap <silent> wm :WMToggle<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=>C.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 let g:C_Ctrl_j   = 'off'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"add by
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"不适用vi的间键盘模式
set nocompatible

syntax enable

"现实光标位置
set ruler

set nohls

set incsearch

set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,sjis,euc-kr,ucs-2le,latin1,gbk,gb2312

"高亮匹配括号
set showmatch

set showcmd

"tab键的宽度
set tabstop=4

"我的状态行显示的内容（包括文件类型和解码）
set statusline=%F%m%r%h%w\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}

" 命令行（在状态行下）的高度，默认为1，这里是2
set cmdheight=2

nmap y :redo<CR>

nmap wm :WMToggle<cr>
map <F2>  wm

map <F3>  <C-W><C-W>

" 格式化代码
map <F8>  100000==

" add function comment
map <C-F> :DoxFunc<CR>

" add license
map <C-L> :DoxLicense<CR>
