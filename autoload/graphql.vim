" Vim plugin
" Language: GraphQL
" Maintainer: Jon Parise <jon@indelible.org>

function! graphql#javascript_tags() abort
  return get(g:, 'graphql_javascript_tags', ['gql', 'graphql', 'Relay.QL'])
endfunction
