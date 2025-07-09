set relativenumber
set shiftwidth=2
set tabstop=2
nnoremap <C-Up> <C-y>
nnoremap <C-Down> <C-e>
nnoremap <C-k> <C-y>
nnoremap <C-j> <C-e>

" inoremap <C-j> <C-O>a{<CR><CR>}<C-O>k<Tab>

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

let mapleader=";"

" " Clipboard
vnoremap <leader>y  "+y
nnoremap <leader>y  "+y
nnoremap <leader>yy "+yy
vnoremap <leader>d  "+d
nnoremap <leader>d  "+d
nnoremap <leader>dd "+dd
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" " One line up/down
"noremap h gh
"noremap j gj
"noremap <Up> g<Up>
"noremap <Down> g<Down>

let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')

vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
noremap <F8> :noremap <F9> :w<C-v><Enter>:!<C-v><Enter><Left>

" Colors
set termguicolors
