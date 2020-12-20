# GraphQL for Vim

This Vim plugin provides [GraphQL](https://graphql.org/) file detection,
syntax highlighting, and indentation. It currently targets the [June 2018
edition](https://graphql.github.io/graphql-spec/June2018/) of the GraphQL
specification.

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
filetype is automatically selected for filenames ending in `.graphql`,
`.graphqls`, and `.gql`.

If you would like to enable automatic syntax support for more file extensions
(e.g., `*.prisma`), create a file named `~/.vim/after/ftdetect/graphql.vim`
containing autocommand lines like:

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

You can also add a `# gql` comment at the start of a template string to
indicate that its contents should be considered GraphQL syntax.

```javascript
const query = `# gql
  {
    user(id: ${uid}) {
      firstName
      lastName
    }
  }
`;
```

Syntax highlighting within `.jsx` / `.tsx` files is also supported. These
filetypes can be "compound" (`javascript.jsx` and `typescript.tsx`) or use the
"react" variants (`javascriptreact` and `typescriptreact`).

Syntax highlighting is also available within [Vue](https://vuejs.org/)
templates.

## ReasonML Support

GraphQL syntax support inside of [ReasonML](https://reasonml.org/) template
strings using [graphql-ppx][] is available.

```reason
[%graphql {|
  query UserQuery {
    user {
      id
      name
    }
  }
|}];
```

[graphql-ppx]: https://github.com/reasonml-community/graphql-ppx

## PHP Support

GraphQL syntax inside of [heredoc][] and [nowdoc][] strings is supported. The
string identifier must be named `GQL` (case-insensitive).

```php
<?php
$my_query = <<<GQL
{
  user(id: ${uid}) {
    firstName
    lastName
  }
}
GQL;
```

[heredoc]: https://www.php.net/manual/language.types.string.php#language.types.string.syntax.heredoc
[nowdoc]: https://www.php.net/manual/language.types.string.php#language.types.string.syntax.nowdoc

## Language Server Protocol Support

[coc-graphql](https://github.com/felippepuhle/coc-graphql) provides a Language
Server Protocol extension for [coc.nvim](https://github.com/neoclide/coc.nvim)
that interoperates with vim-graphql to provide schema-aware features like
autocompletion support.

## Testing

The test suite uses [Vader.vim](https://github.com/junegunn/vader.vim). To run
all of the tests from the command line:

```sh
make test
```

## License

This code is released under the terms of the MIT license. See `LICENSE` for
details.
