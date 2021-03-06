set bg=dark
colorscheme manxome
" colorscheme wombat256
let leave_my_textwidth_alone='yes'      " убираем автоматический перенос строк в текстовых файлах (Gentoo-specific)
syntax on                               " включаем подсветку синтаксиса
set softtabstop=4 shiftwidth=4 expandtab
set cindent                             " отступы в стиле Си
set autoread
set autowrite                           " сохранить файл перед выполнением команды
set number                              " вывод номеров строк
set ruler                               " показывать текущую строку и столбец справа снизу
set is                                  " incremental search
set hlsearch                            " highlight search
set fencs=ucs-bom,utf-8,default,cp1251  " fileencodings: list of char-encs considered when starting to edit an existing file"
set foldenable                          " сворачивание функций и т.п.
set foldmethod=syntax                   " клавиши zc, zo, zr
set mouse=a                             " включить мышь везде, где только можно
set list                                " включить отображение непечатных символов на экране
set listchars=tab:>.,trail:.            " отображать табы и пробелы в конце строки
set complete=.,w,b,u,t                  " автодополнять без поиска по включенным файлам
set diffopt+=iwhite			" игонорировать перевод строки
" пути для удобного открытия инклюдов по gf
" set path=.,,**/include/**;/home/vozbu/programming
set path=.,include/**;/home/vozbu/programming
set path+=/usr/include,/usr/local/**/include,/usr/lib/gcc/x86_64-pc-linux-gnu/*/include/**
" autocmd BufNewFile,BufRead *.cpp set syntax=cpp11   " поддержка синтаксиса C++11 в .cpp-файлах
autocmd BufNewFile,BufRead *.cpp set syntax=cpp   " поддержка синтаксиса C++11 в .cpp-файлах
autocmd BufWritePre * :%s/\s\+$//e      " убираем конечные пробелы при сохранении любого типа файла
autocmd VimLeave * :mksession! ~/.vim.lastsession   " автоматически сохраняем сессию перед выходом
let c_no_curly_error=1                  " запрещаем подсветку {} внутри () как ошибку (для c++0x)

" fix for using in the screen
if match($TERM, "screen")!=-1
  set term=xterm
endif

if has('gui_running')
    set guifont=Terminus\ 10
endif

" insert date
nnoremap <F5> "=strftime("%Y-%m-%d %H:%M")<CR>P
inoremap <F5> <C-R>=strftime("%Y-%m-%d %H:%M")<CR>
map  :w!<CR>:!aspell check %<CR>:e! %<CR>

" чтобы не сохранять в конце файла перевод строки
" set binary
" set noeol

" поиск выделения по *
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" From an idea by Michael Naumann
function! VisualSearch(direction) range
   let l:saved_reg = @"
   execute "normal! vgvy"

   let l:pattern = escape(@", '\\/.*$^~[]')
   let l:pattern = substitute(l:pattern, "\n$", "", "")

   if a:direction == 'b'
      execute "normal ?" . l:pattern . "^M"
   elseif a:direction == 'gv'
      call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
   elseif a:direction == 'f'
      execute "normal /" . l:pattern . "^M"
   endif

   let @/ = l:pattern
   let @" = l:saved_reg
endfunction


function! CmdLine(str)
   exe "menu Foo.Bar :" . a:str
   emenu Foo.Bar
   unmenu Foo
endfunction

" ctags
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
