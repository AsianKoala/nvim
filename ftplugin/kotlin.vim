" Vim filetype plugin file
" Language:     Kotlin
" Maintainer:   Alexander Udalov
" URL:          https://github.com/udalov/kotlin-vim
" Last Change:  7 November 2021

if exists('b:did_ftplugin') | finish | endif
let b:did_ftplugin = 1

let s:save_cpo = &cpo
set cpo&vim
"
" setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
" setlocal commentstring=//\ %s

" setlocal formatoptions-=t formatoptions+=croqnl
" silent! setlocal formatoptions+=j
"
" setlocal includeexpr=substitute(v:fname,'\\.','/','g')
" setlocal suffixesadd=.kt

setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4 

" let b:undo_ftplugin = "setlocal comments< commentstring< ".
"     \ "formatoptions< includeexpr< suffixesadd<"

let b:undo_ftplugin = "setlocal shiftwidth< tabstop< softtabstop<"

let &cpo = s:save_cpo
unlet s:save_cpo
