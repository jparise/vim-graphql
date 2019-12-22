# GraphQL for Vim

This is a [Vim](https://www.vim.org/) plugin that provides [GraphQL][gql] file
detection, syntax highlighting, and indentation. It currently targets the
[June 2018 specification][spec].

## Installation

### Using [vim-plug](https://github.com/junegunn/vim-plug)

1. Add `Plug 'jparise/vim-graphql'` to `~/.vimrc`
2. `vim +PluginInstall +qall`

### Using Vim Packages

```sh
mkdir -p ~/.vim/pack/jparise/start
cd ~/.vim/pack/jparise/start
git clone https://github.com/jparise/vim-graphql.git graphql
vim -u NONE -c "helptags graphql/doc" -c q
```

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

## JavaScript and TypeScript Support

GraphQL syntax support inside of [ES2015 template literals][templates] is
provided. It works "out of the box" with Vim 8.2+'s JavaScript and TypeScript
language support. The extended JavaScript syntax provided by the
[vim-javascript][] plugin is also supported.

For older versions of Vim, TypeScript support can be enabled by installing the
[yats][] plugin.

[templates]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Template_literals#Tagged_templates
[vim-javascript]: https://github.com/pangloss/vim-javascript
[yats]: https://github.com/HerringtonDarkholme/yats.vim

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

Syntax highlighting within `.jsx` / `.tsx` files is also supported. These
filetypes can be "compound" (`javascript.jsx`) or use the "react" variant
(`javascriptreact`).

Syntax highlighting is also available within Vue templates.

## Testing

The test suite uses [Vader.vim][]. To run all of the tests from the command
line:

```sh
make test
```

## License

This code is released under the terms of the MIT license. See `LICENSE` for
details.

[gql]: http://graphql.org/
[spec]: https://graphql.github.io/graphql-spec/June2018/
[vader.vim]: https://github.com/junegunn/vader.vim
