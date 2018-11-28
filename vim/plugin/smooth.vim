" Author: Matt Simmons <matt.simmons at compbiol.org>
" License: MIT license

scriptencoding utf-8

if exists('g:loaded_smooth')
  finish
endif
if !has('patch-7.4.1285') && !has('nvim')
  finish
endif
let g:loaded_smooth = 1

let s:save_cpo = &cpo
set cpo&vim

nnoremap <silent> <Plug>(SmoothUp)        :call smooth#scroll(-&scroll, 1)<CR>
nnoremap <silent> <Plug>(SmoothDown)      :call smooth#scroll(&scroll, 1)<CR>
nnoremap <silent> <Plug>(SmoothPageUp)    :call smooth#scroll(-&scroll * 2, 0)<CR>
nnoremap <silent> <Plug>(SmoothPageDown)  :call smooth#scroll(&scroll * 2, 0)<CR>
nnoremap <silent> <Plug>(Smooth_zCR)     ^:<C-u>call smooth#scroll(winline() - &scrolloff, 0)<CR>
nnoremap <silent> <Plug>(Smooth_zt)       :<C-u>call smooth#scroll(winline() - &scrolloff - 1, 0)<CR>
nnoremap <silent> <Plug>(Smooth_z.)      ^:<C-u>call smooth#scroll(winline() - winheight(0)/2, 0)<CR>
nnoremap <silent> <Plug>(Smooth_zz)       :<C-u>call smooth#scroll(winline() - winheight(0)/2, 0)<CR>
nnoremap <silent> <Plug>(Smooth_z-)      ^:<C-u>call smooth#scroll(winline() - winheight(0) + &scrolloff, 0)<CR>
nnoremap <silent> <Plug>(Smooth_zb)       :<C-u>call smooth#scroll(winline() - winheight(0) + &scrolloff, 0)<CR>
nnoremap <silent> <Plug>(SmoothC-e)       :<C-u>call smooth#scroll(v:count1, 0)<CR>
nnoremap <silent> <Plug>(SmoothC-y)       :<C-u>call smooth#scroll(- v:count1, 0)<CR>


let s:bindings = {
      \  '<C-u>' : '<Plug>(SmoothUp)',
      \  '<C-d>' : '<Plug>(SmoothDown)',
      \  '<C-b>' : '<Plug>(SmoothPageUp)',
      \  '<C-f>' : '<Plug>(SmoothPageDown)',
      \  'z<CR>' : '<Plug>(Smooth_zCR)',
      \  'zt'    : '<Plug>(Smooth_zt)',
      \  'z.'    : '<Plug>(Smooth_z.)',
      \  'zz'    : '<Plug>(Smooth_zz)',
      \  'z-'    : '<Plug>(Smooth_z-)',
      \  'zb'    : '<Plug>(Smooth_zb)',
      \  '<C-e>' : '<Plug>(SmoothC-e)',
      \  '<C-y>' : '<Plug>(SmoothC-y)'
      \ }

if !exists('g:smooth_nobind')
  for s:bind in keys(s:bindings)
    if !hasmapto(s:bindings[s:bind]) && maparg(s:bind, 'n') ==# ''
      execute	'nmap ' . s:bind . ' ' . s:bindings[s:bind]
    endif
  endfor
endif

let &cpo = s:save_cpo
unlet s:save_cpo
" vim: set ts=2 sw=2 tw=99 et :
