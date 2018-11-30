if exists('b:current_syntax')
  let s:current_syntax = b:current_syntax
  unlet b:current_syntax
endif
syn include @GraphQLSyntax syntax/graphql.vim
if exists('s:current_syntax')
  let b:current_syntax = s:current_syntax
endif

let s:tags = '\%(' . join(g:graphql_javascript_tags, '\|') . '\)'

exec 'syntax region graphqlTemplateString start=+' . s:tags . '\@20<=`+ skip=+\\`+ end=+`+ contains=@GraphQLSyntax,typescriptTemplateSubstitution extend'
exec 'syntax match graphqlTaggedTemplate +' . s:tags . '\ze`+ nextgroup=graphqlTemplateString'

exec 'syntax region graphqlTemplateString start=+`#\s\{0,4\}gql\>\s*$+ skip=+\\`+ end=+`+ contains=@GraphQLSyntax,j:qsTemplateExpression,jsSpecial extend'

" Support expression interpolation ((${...})) inside template strings.
syntax region graphqlTemplateExpression start=+${+ end=+}+ contained contains=typescriptTemplateSubstitution containedin=graphqlFold keepend

hi def link graphqlTemplateString typescriptTemplate
hi def link graphqlTemplateExpression typescriptTemplateSubstitution

syn cluster typescriptExpression add=graphqlTaggedTemplate
syn cluster graphqlTaggedTemplate add=graphqlTemplateString
