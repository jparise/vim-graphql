" Vim plugin
" Language: GraphQL
" Maintainer: Jon Parise <jon@indelible.org>

function! graphql#has_syntax_group(group) abort
  try
    silent execute 'silent highlight ' . a:group
  catch
    return v:false
  endtry
  return v:true
endfunction

function! graphql#javascript_tags() abort
  return get(g:, 'graphql_javascript_tags', ['gql', 'graphql', 'Relay.QL'])
endfunction
