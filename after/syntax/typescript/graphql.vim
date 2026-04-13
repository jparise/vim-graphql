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

call graphql#embed_syntax('typescriptGraphQL')

let s:tags = graphql#javascript_tags()
let s:functions = graphql#javascript_functions()

if !empty(s:tags)
  exec 'syntax region graphqlTemplateString matchgroup=typescriptTemplate '
        \ 'start=+\%(' . join(s:tags, '\|') . '\)\@20<=`+ skip=+\\`+ end=+`+ '
        \ 'contains=@typescriptGraphQL,typescriptTemplateSubstitution extend'
  exec 'syntax match graphqlTaggedTemplate +\%(' . join(s:tags, '\|') . '\)\ze`+ '
        \ 'nextgroup=graphqlTemplateString'
endif
if !empty(s:functions)
  exec 'syntax match graphqlFunctionCall +\%(' . join(s:functions, '\|') . '\)\ze\s*(+ '
        \ 'nextgroup=typescriptFuncCallArg skipwhite skipnl'
  syntax region graphqlFunctionLiteral matchgroup=typescriptTemplate
        \ start=+`+ skip=+\\`+ end=+`+
        \ contains=@typescriptGraphQL,typescriptTemplateSubstitution
        \ containedin=typescriptFuncCallArg contained extend
endif

" Support expression interpolation ((${...})) inside template strings.
syntax region graphqlTemplateExpression start=+${+ end=+}+ contained contains=typescriptTemplateSubstitution containedin=graphqlFold keepend

" support #graphql , #gql comment strings
syntax region graphqlTemplateString
      \ start=+`\(#\s\{,4\}\(gql\|graphql\)\)\@=+
      \ skip=+\\\\\|\\`+
      \ end=+`+me=s-1
      \ containedin=typescriptTemplate
      \ contained
      \ contains=@typescriptGraphQL,typescriptTemplateSubstitution extend

hi def link graphqlTemplateString typescriptTemplate
hi def link graphqlFunctionLiteral typescriptTemplate
hi def link graphqlFunctionCall typescriptFuncName
hi def link graphqlTemplateExpression typescriptTemplateSubstitution

syn cluster typescriptExpression add=graphqlTaggedTemplate,graphqlFunctionCall
syn cluster graphqlTaggedTemplate add=graphqlTemplateString,graphqlFunctionLiteral
