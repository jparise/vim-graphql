# GraphQL for Vim

This is a [Vim](https://www.vim.org/) plugin that provides [GraphQL][gql] file
detection, syntax highlighting, and indentation. It currently targets the
[June 2018 specification][spec].

## Installation

### Using [Plug][]

1. Add `Plug 'jparise/vim-graphql'` to `~/.vimrc`
2. `vim +PluginInstall +qall`

### Using [Vundle][]

1. Add `Plugin 'jparise/vim-graphql'` to `~/.vimrc`
2. `vim +PluginInstall +qall`

### Using [Pathogen][]

1. `cd ~/.vim/bundle`
2. `git clone https://github.com/jparise/vim-graphql.git`

## Syntax Highlighting

Complete syntax highlighting is enable for the `graphql` [filetype][]. This
filetype is automatically selected for file names ending in `.graphql`,
`.graphqls`, and `.gql`.

If you would like to enable syntax support for custom extensions, for example
`.prisma`, create a new file named `~/.vim/ftdetect/prisma.vim` containing:

```vim
au BufNewFile,BufRead *.prisma setfiletype graphql
```

[filetype]: http://vimdoc.sourceforge.net/htmldoc/filetype.html

## JavaScript / TypeScript Support

When the [vim-javascript](https://github.com/pangloss/vim-javascript) or
[yats](https://github.com/HerringtonDarkholme/yats.vim) plugins are installed,
GraphQL syntax support in [ES2015 template literals][templates] is enabled.

[templates]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Template_literals#Tagged_templates

```javascript
const query = gql`
  {
    user(id: ${uid}) {
      firstName
      lastName
    }
  }
`;
```

The list of recognized tag names is defined by the `g:graphql_javascript_tags`
variable, which defaults to `["gql", "graphql", "Relay.QL"]`.

## TSX/JSX

This plugin now supports syntax highlighting within `.tsx` / `.jsx` files.

Should you have any problems with this I would suggest adding the following to your `init.vim`/`.vimrc` file:

```vim
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx
```

## Testing

The test suite uses [Vader.vim][]. To run all of the tests from the command
line:

    $ make test

[gql]: http://graphql.org/
[spec]: https://graphql.github.io/graphql-spec/June2018/
[pathogen]: https://github.com/tpope/vim-pathogen
[plug]: https://github.com/junegunn/vim-plug
[vundle]: https://github.com/gmarik/vundle
[vader.vim]: https://github.com/junegunn/vader.vim
