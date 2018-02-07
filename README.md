# GraphQL for Vim

[![Build Status](https://travis-ci.org/jparise/vim-graphql.svg)](https://travis-ci.org/jparise/vim-graphql)

This is a [Vim](http://www.vim.org/) plugin that provides [GraphQL][gql] file
detection, syntax highlighting, and indentation. It currently targets the
[October 2016 draft specification][spec].

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

## JavaScript / TypeScript Support

When the [vim-javascript](https://github.com/pangloss/vim-javascript) or
[yats](https://github.com/HerringtonDarkholme/yats.vim) plugins are installed,
GraphQL syntax support in ES6 tagged template literals is enabled.

## Testing

The test suite uses [Vader.vim][]. To run all of the tests from the command
line:

    $ make test

[gql]: http://graphql.org/
[spec]: https://facebook.github.io/graphql/October2016/
[Pathogen]: https://github.com/tpope/vim-pathogen
[Plug]: https://github.com/junegunn/vim-plug
[Vundle]: https://github.com/gmarik/vundle
[Vader.vim]: https://github.com/junegunn/vader.vim
