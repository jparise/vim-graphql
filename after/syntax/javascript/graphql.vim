" Prologue; load in GraphQL syntax.
if exists('b:current_syntax')
  let s:current_syntax=b:current_syntax
  unlet b:current_syntax
endif
syn include @GraphQLSyntax syntax/graphql.vim
if exists('s:current_syntax')
  let b:current_syntax=s:current_syntax
endif

syntax region graphqlTemplateString start=+`+ skip=+\\\(`\|$\)+ end=+`+ contains=@GraphQLSyntax,jsTemplateVar,jsSpecial extend
exec 'syntax match graphqlTaggedTemplate +\%(' . join(g:graphql_tag_names, '\|') . '\)\%(`\)\@=+ nextgroup=graphqlTemplateString'

hi def link graphqlTemplateString           jsTemplateString
hi def link graphqlTaggedTemplate           jsTaggedTemplate

syn cluster jsExpression add=graphqlTaggedTemplate
syn cluster graphqlTaggedTemplate add=graphqlTemplateString
