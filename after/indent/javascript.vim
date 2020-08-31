" Copyright (c) 2016-2020 Jon Parise <jon@indelible.org>
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to
" deal in the Software without restriction, including without limitation the
" rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
" sell copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
" FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
" IN THE SOFTWARE.
"
" Language: GraphQL
" Maintainer: Jon Parise <jon@indelible.org>

runtime! indent/graphql.vim

" Don't redefine our function and also require the standard Javascript indent
" function to exist.
if exists('*GetJavascriptGraphQLIndent') || !exists('*GetJavascriptIndent')
  finish
endif

" Set the indentexpr with our own version that will call GetGraphQLIndent when
" we're inside of a GraphQL string and otherwise defer to GetJavascriptIndent.
setlocal indentexpr=GetJavascriptGraphQLIndent()

function GetJavascriptGraphQLIndent()
  let l:stack = map(synstack(v:lnum, 1), "synIDattr(v:val,'name')")
  if !empty(l:stack) && l:stack[0] ==# 'graphqlTemplateString'
    return GetGraphQLIndent()
  endif

  return GetJavascriptIndent()
endfunction
