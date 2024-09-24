"compatibility with vi off
set nocompatible
 
" file type detection
filetype on
 
" enable plugins
"
filetype plugin on
 
filetype indent on
 
syntax on
 
set number

set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
 
set cursorline
set cursorcolumn
 
set shiftwidth=4
set tabstop=4
set expandtab
set nobackup
 
set scrolloff=10
set nowrap
set incsearch
set ignorecase
set smartcase
 
" set showcmd
set showmode
 
set hlsearch
set history=20
 
" Save the cursor position when closing a file
augroup SaveCursorPosition
    autocmd!
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif
augroup END 
 
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
 
set foldmethod=indent
set foldlevel=99  " Open all folds by default

" PLUGINS ---------------------------------------------------------------- {{{
 
call plug#begin('~/.vim/plugged')
" Plug 'preservim/nerdtree'
" Plug 'jiangmiao/auto-pairs'
Plug 'dense-analysis/ale'
 
call plug#end()
 
" }}}
 
 
" MAPPINGS --------------------------------------------------------------- {{{
 
:command Tree NERDTree
 
" }}}
 
 
" VIMSCRIPT -------------------------------------------------------------- {{{
 
" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END 
 
function! CreateFunction(...)
    " Capture all additional arguments
    let args = split(a:000[0])
 
    " Extract the function name and prepare the arguments
    let function_name = args[0]
    let arg_string = ''
 
    " Check if there are additional arguments
    if len(args) > 1 
        " Start building the argument string
        let arg_string = '(' 
        " Iterate over arguments, skipping the function name
        for i in range(1, len(args) - 1)
            let arg_string .= args[i] . ', '
        endfor
        " Add the last argument and close the parenthesis
        let arg_string .= args[len(args) - 1] . ')' 
    else
        let arg_string = '()'
    endif
 
    let lines = [ 'const ' . function_name . ' = ' . arg_string . ' => {', '    // Your code here', '};' ]
 
    " Insert the function definition at the current line
    call setline('.', lines[0])
    call append(line('.'), lines[1])
    call append(line('.'), lines[2])
endfunction
 
" Define a custom command to call the CreateFunction function
command! -nargs=* Fn call CreateFunction(<q-args>)
 
 
" }}}
" STATUS LINE ------------------------------------------------------------ {{{
 
" Status bar code goes here.
 
" }}}
