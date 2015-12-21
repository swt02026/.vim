" execute pathogen#infect()                   " Activate pathogen
execute pathogen#infect()

filetype plugin indent on

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Send more characters for redraws
set ttyfast

" If linux then set ttymouse
let s:uname = system("echo -n \"$(uname)\"")
if !v:shell_error && s:uname == "Linux"
  "set ttymouse=xterm
  set ttymouse=xterm2
endif
let g:solarized_termcolors=256
syntax on                       " turns syntax highlighting on
colorscheme default             " defines the color scheme of the syntax highlighting
set background=dark             " expect a dark console background

set nocompatible                " (cp) use Vim defaults (much better)
set ruler                       " (ru) show the cursor position at all times
set showcmd                     " (sc) display an incomplete command in the lower right
set history=50                  " (hi) keep 50 lines of command history
set number                      " (nu) show line numbers
set showmatch                   " (sm) briefly jump to matching bracket when inserting one
set autoindent                  " (ai) turn on auto-indenting (great for programers)
set copyindent                  " (ci) when auto-indenting, use the indenting format of the previous line
set tabstop=2                   " (ts) width (in spaces) that a <tab> is displayed as
set expandtab
set shiftwidth=2                " (sw) width (in spaces) used in each step of autoindent (aswell as << and >>)
"set smarttab                   " (sta) 'shiftwidth' used in front of a line, but 'tabstop' used otherwise
"set textwidth=80                " (tw) number of columns before an automatic line break is inserted (see formatoptions)
"set formatoptions=croq          " (fo) influences how vim automatically formats text
"set backspace=indent,eol,start  " (bs) allows backspacing beyond starting point of insert mode, indents and line breaks
"set nrformats+=alpha            " (nf) adds alpha chars to list that gets incremented/decremented with ^A/^X
"set listchars+=tab:>-           " (lcs) strings used in 'list' mode to show hidden characters (default=eol:$)
"set listchars+=trail:-
set winminheight=0              " (wmh) the minimal height of the window when it's not the current window

"set nowrap                     " allows text to continue off the window (need horizontal scrolling)
"set linebreak                   " (lbr) wrap long lines at a space instead of in the middle of a word
set sidescroll=5                " (ss) the minimal number of columns to scroll horizontally
set listchars+=precedes:<       " (lcs) when 'nowrap', character to indicate that line continues off the page
set listchars+=extends:>

set wrapscan                    " (ws) allows search to wrap to top of document when the bottom has been hit
set incsearch                   " (is) highlights what you are searching for as you type
set hlsearch                    " (hls) highlights all instances of the last searched string
set ignorecase                  " (ic) ignores case in search patterns
set smartcase                   " (scs) don't ignore case when the search pattern has uppercase
set infercase                   " (inf) during keyword completion, fix case of new word (when ignore case is on)

"set foldcolumn=6                " (fdc) width of fold column (to see where folds are)
"set foldmethod=indent           " (fdm) creates a fold for every level of indentation
"set foldlevel=99                " (fdl) when file is opened, don't close any folds
"set foldenable                  " (fen) enables or disables folding

"set backup                     " (bk) will create a backup before overwriting a file
"set backupext=.bkup            " (bex) defines the extension used in a backup file (default is '~')

set hidden                      " Hide buffers instead of closing them

" File Specific Settings
" ------------------------------------------------------------

au FileType xhtml,html,htm,php,xml,js setlocal tabstop=2
au FileType xhtml,html,htm,php,xml,js setlocal shiftwidth=2
"au FileType xhtml,html,htm,php,xml setlocal expandtab      " (et) expand tabs to spaces (use :retab to redo entire file)
au FileType xhtml,html,htm,php,xml,js setlocal softtabstop=2   " (sts) makes spaces feel like tabs (like deleting)

au FileType c,h,java,js setlocal mps+==:;                   " allow the match pairs operation (%) to work with '=' and ';'

au FileType c,h setlocal cindent                            " enable the intelligent cindent (cin) feature for the following files
au FileType java,js setlocal smartindent                    " enable the smartindenting (si) feature for the following files

au FileType txt setlocal fo+=tn


" Abbreviations
" ------------------------------------------------------------

abbreviate #i #include
abbreviate #d #define

abbreviate <a <a href=""></a><left><left><left><left><left><left>
abbreviate <i <img src="" /><left><left><left><left><left>
abbreviate l" &ldquo;&rdquo;<left><left><left><left><left><left>
abbreviate r" &rdquo;
abbreviate l' &lsquo;
abbreviate r' &rsquo;
abbreviate "" &quot;&quot;<left><left><left><left><left>

abbreviate <? <?php?><left><left>

" Command Reference
" ------------------------------------------------------------

" *                     - searches for word under cursor
" gd                    - finds definition of variable/function under cursor
" ga                    - prints the ascii value of character under cursor
" gf                    - opens file under the cursor (in split view)
" gi                    - goes to insert mode in the same spot as you last inserted
" ~                     - changes case of character
" :r !<cmd>             - reads the output of the shell <cmd> into the file
" :% s/hello/A/gc       - typical search and replace command

" :% !tidy              - runs the code through the 'tidy' program

" :runtime! syntax/2html.vim
" :10,40TOhtml

" command reference ->  " za : fold toggle  toggles between a fold being opened and closed (zA does it recursively)
"                       " zc : fold close   close 1 fold under the cursor (zC does it recursively)
                        " zo : fold open    open 1 fold under the cursor (zO does it recursively)
                        " zm : fold more    increases foldlevel by 1 (zM opens all folds)
                        " zr : fold reduce  decreses foldlevel by 1 (zR closes all folds)

" :retab                - when expandtab is set, replace all tabs in the file with the # of spaces defined in 'shiftwidth'
" :retab!               - when expandtab is not set, replace the number of spaces in 'shiftwidth' with a tab
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb

    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif

let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" Press i to enter insert mode, and ii to exit.
:imap ii <Esc>

" Press <F7> to jump to previous tab and <F8> to jump to next tab
:nmap <F7> :tabp<CR>
:nmap <F8> :tabn<CR>

" Enable clang-format for NORMAL and VISUAL mode (Ctrl+i)
map <C-I> :pyf /usr/share/vim/addons/syntax/clang-format-3.6.py<cr>
" Enable clang-format for INSERT mode (Ctrl+i)
imap <C-I> <c-o>:pyf /usr/share/vim/addons/syntax/clang-format-3.6.py<cr>


"------------------------------
" Add vim airline configuration
"------------------------------
set laststatus=2
" See https://github.com/bling/vim-airline#smarter-tab-line
let g:airline#extensions#tabline#enabled = 1

" Mapping to NERDTree
nmap <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.vim$', '\~$', '\.git$', '.DS_Store']
let NERDChristmasTree=1

" vim-go mappings
let g:go_fmt_command = "goimports"
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif
