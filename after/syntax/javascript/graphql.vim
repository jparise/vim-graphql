if exists('b:current_syntax')
  let s:current_syntax = b:current_syntax
  unlet b:current_syntax
endif
syn include @GraphQLSyntax syntax/graphql.vim
if exists('s:current_syntax')
  let b:current_syntax = s:current_syntax
endif

let s:tags = '\%(' . join(graphql#javascript_tags(), '\|') . '\)'

if graphql#has_syntax_group('jsTemplateExpression')
  " pangloss/vim-javascript
  exec 'syntax region graphqlTemplateString start=+' . s:tags . '\@20<=`+ skip=+\\\\\|\\`+ end=+`+ contains=@GraphQLSyntax,jsTemplateExpression,jsSpecial extend'
  exec 'syntax match graphqlTaggedTemplate +' . s:tags . '\ze`+ nextgroup=graphqlTemplateString'
  syntax region graphqlTemplateExpression start=+${+ end=+}+ contained contains=jsTemplateExpression containedin=graphqlFold keepend

  hi def link graphqlTemplateString jsTemplateString
  hi def link graphqlTaggedTemplate jsTaggedTemplate
  hi def link graphqlTemplateExpression jsTemplateExpression

  syn cluster jsExpression add=graphqlTaggedTemplate
  syn cluster graphqlTaggedTemplate add=graphqlTemplateString
elseif graphql#has_syntax_group('javaScriptStringT')
  " runtime/syntax/javascript.vim
  exec 'syntax region graphqlTemplateString start=+' . s:tags . '\@20<=`+ skip=+\\\\\|\\`+ end=+`+ contains=@GraphQLSyntax,javaScriptSpecial,javaScriptEmbed extend'
  exec 'syntax match graphqlTaggedTemplate +' . s:tags . '\ze`+ nextgroup=graphqlTemplateString'
  syntax region graphqlTemplateExpression start=+${+ end=+}+ contained contains=@javaScriptEmbededExpr containedin=graphqlFold keepend

  hi def link graphqlTemplateString javaScriptStringT
  hi def link graphqlTaggedTemplate javaScriptEmbed
  hi def link graphqlTemplateExpression javaScriptEmbed

  syn cluster javaScriptEmbededExpr add=graphqlTaggedTemplate
  syn cluster graphqlTaggedTemplate add=graphqlTemplateString
endif
