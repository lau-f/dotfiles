" vim/neovim config

" Use Vim settings - must be first, because it changes other options.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Indents
set tabstop=4
set expandtab
set shiftwidth=4

" Search
set nowrapscan
set ignorecase
set smartcase

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" Vimgrep the word under the cursor
nmap <silent><C-\>v :vimgrep #<C-R><C-W># %<CR> :cwin<CR>

" " always use the command-line window
" " Note: press C-f in command-line to switch to command-line window
" nnoremap : q:i
" set cmdwinheight=2

if has("vms")
  set nobackup      " do not keep a backup file, use versions instead
else
  set backup        " keep a backup file
endif
set history=500     " lines of command line history
set ruler           " show the cursor position all the time
set showcmd         " display incomplete commands
set incsearch       " do incremental searching

" Modify default grep for more convenient options
set grepprg=grep\ -nHIs\ --exclude-dir={.repo,.git}\ --exclude={cscope.\\*,\\*~}\ $*\ /dev/null
"set grepprg=ag\ -vimgrep\ --ignore={.repo,.git}\ --ignore={cscope.\\*,\\*~}\ $*\ /dev/null

" Minimal UI/interaction
set go=
set mouse=

" Doxygen highlighting
" - enable
let g:load_doxygen_syntax=1
"let g:doxygen_enhanced_color = 1
" - always highlght first line even without @brief
let doxygen_javadoc_autobrief = 1
" - end characters
let doxygen_end_punctuation = '[.\n]'

" Highlight tabs/spaces
" - highlight tabs at the beginning of a line
:highlight TabHighlight ctermbg=darkgrey guibg=darkgrey
:autocmd ColorScheme * highlight TabHighlight ctermbg=darkgrey guibg=darkgrey
" - all tabs and space characters at the end of lines
":autocmd BufWinEnter * match TabHighlight /	\|\s\+$/
" - space characters at the end of lines only
:autocmd BufWinEnter * match TabHighlight /\s\+$/

" List characters
"set listchars=tab:>.
set listchars=tab:▸˲
set list

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
syntax on
set hlsearch
"highlight Normal guibg=grey10

" Cscope
if has('cscope')
    " unset - avoid annoying messages "set cscopetag cscopeverbose

    if has('quickfix')
        set cscopequickfix=s-,c-,d-,i-,t-,e-,g-,f-
    endif
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Handle Android .aidl files as java
  autocmd BufReadPost *.aidl set syntax=java

  " Detect logcat files
  autocmd BufReadPost *aplog* set syntax=logcat
  autocmd BufReadPost *logcat*log set syntax=logcat

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent        " always set autoindenting on

endif " has("autocmd")

" Plugins
call plug#begin('~/.config/nvim/plugged')

" Git
Plug 'tpope/vim-fugitive'
" Complementary bindings eg. ]q [q
Plug 'tpope/vim-unimpaired'
" Modify surroundings of a region eg. add " around a word
Plug 'tpope/vim-surround'

" Dispatch asynchronous jobs + dispatch in neovim shell
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'

" Replace nerdtree with vinegar - simple extension of netrw
" Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-vinegar'

" readline shortcuts for command-line and edit
Plug 'tpope/vim-rsi'

" Code check
Plug 'scrooloose/syntastic'

" Select a window to swap with another window
Plug 'wesQ3/vim-windowswap'

" See a simple diff compared to git HEAD
Plug 'airblade/vim-gitgutter'

" cscope official bindings (clone)
"Plug 'chazy/cscope_maps'
Plug 'simplyzhao/cscope_maps.vim'

" Undo tree
Plug 'sjl/gundo.vim'

" Sidebar with current file's symbols
Plug 'majutsushi/tagbar'

" Gnu global
Plug 'gtags.vim'

" Add signs for quickfix, jump, marks...
" Plug 'tomtom/quickfixsigns_vim'

" Mark extra whitespaces in red and provide autofix... not always relevant...
" Plug 'ntpeters/vim-better-whitespace'

"...ko?... Plug 'lilydjwg/colorizer'

" Another highlight plugin - complicated bindings
"Plug 't9md/vim-quickhl'
" Highlight plugin - see also Simple highlighting: http://www.vim.org/scripts/script.php?script_id=4688
" Highlight words with various colors with a simple key binding
Plug 'Mark--Karkat'

" --- language support --
" Go language support
Plug 'fatih/vim-go'
" Enhanced c++ highlighting
Plug 'octol/vim-cpp-enhanced-highlight'
" Bitbake
Plug 'kergoth/vim-bitbake'
" Kotlin
Plug 'udalov/kotlin-vim'

" Convert PDF to text when opening a file
Plug 'rhysd/open-pdf.vim'

" unite
Plug 'shougo/unite.vim'
Plug 'shougo/vimproc'
" global support with unite
Plug 'hewes/unite-gtags'

" ctrl-p - fuzzy finding
Plug 'kien/ctrlp.vim'

" auto completion /!\ Requires vim compiled with python support /!\
"Plug 'Valloric/YouCompleteMe'
" See also alternate
"Plug 'shougo/neocomplete.vim'

" grep using ag
" use ack.vim instead as it can also use ag and supports dispatch
" Plug 'rking/ag.vim'
" ack works fine in vim but returns empty strings in nvim :S
" Plug 'mileszs/ack.vim'
" kind of OK but some weird behavior / background search no status/c-c
" Plug 'mhinz/vim-grepper'
" specifically for nvim - async search but no dispatch
" Plug 'Numkil/ag.nvim'

" Code commenting
Plug 'tpope/vim-commentary'
" See also nerd commenter

" Extended repeat (works with surround etc.)
Plug 'tpope/vim-repeat'

" See also snippets
" See also easymotion
" http://benmccormick.org/2014/07/21/learning-vim-in-2014-getting-more-from-vim-with-plugins/

" Integration with tmux
" https://github.com/christoomey/vim-tmux-navigator

" auto parenthesis
" https://github.com/Raimondi/delimitMate

" Markdown
" https://github.com/plasticboy/vim-markdown
" See also tpope markdown

"" Eye candy
" Powerline status bar
" Plug 'Lokaltog/powerline'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

""" colorschemes
" Solarized
Plug 'altercation/vim-colors-solarized'
" Base16
" Plug 'chriskempson/base16-vim'
" Molokai
Plug 'tomasr/molokai'
" Desert Enhanced
Plug 'mbbill/desertex'
" Xoria - very nice colors for vimdiff
Plug 'xoria256.vim'

Plug 'benekastah/neomake'
call plug#end()

"   Tagbar
let g:tagbar_left=1

"   gitgutter - disable by default
let g:gitgutter_enabled = 0
let g:syntastic_mode_map = { "mode": "passive" }

"   openpdf - convert on open
let g:pdf_convert_on_edit = 1
let g:pdf_convert_on_read = 1

" "   ack -> use ag
" let g:ack_use_dispatch = 1
" if executable('ag')
"     let g:ackprg = 'ag --vimgrep'
" endif

" Airline
let g:airline#extensions#whitespace#enabled = 0
let g:airline_theme='sol'

" Neovim
if has('nvim')
    " Fix <alt> behavior in terminal
    tnoremap <M-b> <Esc>b
    tnoremap <M-f> <Esc>f
    tnoremap <M-d> <Esc>d
endif

colorscheme xoria256
highlight ColorColumn ctermbg=Black
