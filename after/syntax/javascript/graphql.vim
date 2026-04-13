" Copyright (c) Jon Parise <jon@indelible.org>
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

call graphql#embed_syntax('javaScriptGraphQL')

let s:tags = graphql#javascript_tags()
let s:functions = graphql#javascript_functions()

if !empty(s:tags)
  exec 'syntax match graphqlTaggedTemplate +\%(' . join(s:tags, '\|') . '\)\ze`+ '
        \ 'nextgroup=graphqlTemplateString'
  exec 'syntax region graphqlTemplateString matchgroup=javaScriptStringT '
        \ 'start=+\%(' . join(s:tags, '\|') . '\)\@20<=`+ skip=+\\\\\|\\`+ end=+`+ '
        \ 'contains=@javaScriptGraphQL,javaScriptSpecial,javaScriptEmbed,@htmlPreproc '
        \ 'extend'
endif
if !empty(s:functions)
  exec 'syntax match graphqlFunctionCall +\%(' . join(s:functions, '\|') . '\)\ze\s*(+ '
        \ 'nextgroup=graphqlFunctionArgs skipwhite skipnl'
  syntax region graphqlFunctionArgs start=+(+ end=+)+
        \ contains=graphqlFunctionLiteral
        \ contained transparent extend
  syntax region graphqlFunctionLiteral matchgroup=javaScriptStringT
        \ start=+`+ skip=+\\\\\|\\`+ end=+`+
        \ contains=@javaScriptGraphQL,javaScriptSpecial,javaScriptEmbed,@htmlPreproc
        \ contained extend
endif
syntax region graphqlTemplateString matchgroup=javaScriptStringT
      \ start=+`#\s\{,4\}\(gql\|graphql\)\>\s*$+ skip=+\\\\\|\\`+ end=+`+
      \ contains=@javaScriptGraphQL,javaScriptSpecial,javaScriptEmbed,@htmlPreproc
      \ extend
syntax region graphqlTemplateExpression 
      \ start=+${+ end=+}+
      \ contains=@javaScriptEmbededExpr contained containedin=graphqlFold
      \ keepend

hi def link graphqlTemplateString javaScriptStringT
hi def link graphqlFunctionLiteral javaScriptStringT
hi def link graphqlTaggedTemplate javaScriptEmbed
hi def link graphqlFunctionCall javaScriptEmbed
hi def link graphqlTemplateExpression javaScriptEmbed

syn cluster htmlJavaScript add=graphqlTaggedTemplate,graphqlFunctionCall
syn cluster javaScriptEmbededExpr add=graphqlTaggedTemplate,graphqlFunctionCall
syn cluster graphqlTaggedTemplate add=graphqlTemplateString,graphqlFunctionLiteral

" pangloss/vim-javascript
if hlexists('jsTemplateString')
  if !empty(s:tags)
    exec 'syntax region graphqlTemplateString matchgroup=jsTemplateString '
          \ 'start=+\%(' . join(s:tags, '\|') . '\)\@20<=`+ skip=+\\`+ end=+`+ '
          \ 'contains=@javaScriptGraphQL,jsTemplateExpression,jsSpecial extend'
  endif
  if !empty(s:functions)
    exec 'syntax match graphqlFunctionCall +\%(' . join(s:functions, '\|') . '\)\ze\s*(+ '
          \ 'nextgroup=graphqlFunctionArgs skipwhite skipnl'
    syntax region graphqlFunctionArgs matchgroup=jsParens start=+(+ end=+)+
          \ contains=@jsExpression,graphqlFunctionLiteral
          \ contained extend fold
    syntax region graphqlFunctionLiteral matchgroup=jsTemplateString
          \ start=+`+ skip=+\\`+ end=+`+
          \ contains=@javaScriptGraphQL,jsTemplateExpression,jsSpecial
          \ contained extend
  endif
  syntax region graphqlTemplateString matchgroup=jsTemplateString
        \ start=+`#\s\{,4\}\(gql\|graphql\)\>\s*$+ skip=+\\`+ end=+`+
        \ contains=@javaScriptGraphQL,jsTemplateExpression,jsSpecial extend
  syntax region graphqlTemplateExpression
        \ start=+${+ end=+}+
        \ contains=jsTemplateExpression contained containedin=graphqlFold
        \ keepend

  " Relink the default highlights we made above to the vim-javascript groups.
  hi! def link graphqlTemplateString jsTemplateString
  hi! def link graphqlFunctionLiteral jsTemplateString
  hi! def link graphqlTaggedTemplate jsTaggedTemplate
  hi! def link graphqlFunctionCall jsFuncCall
  hi! def link graphqlTemplateExpression jsTemplateExpression

  syn cluster jsExpression add=graphqlTemplateString,graphqlTaggedTemplate,graphqlFunctionCall
endif
