.PHONY: test

all: lint test

lint:
	vint -s after ftdetect ftplugin indent plugin syntax

test: test/vader.vim test/vim-javascript test/yats.vim
	cd test && vim -Nu vimrc -c 'Vader! *' > /dev/null

test/vader.vim:
	git clone --depth 1 https://github.com/junegunn/vader.vim.git test/vader.vim

test/vim-javascript:
	git clone --depth 1 https://github.com/pangloss/vim-javascript.git test/vim-javascript

test/yats.vim:
	git clone --depth 1 https://github.com/HerringtonDarkholme/yats.vim.git test/yats.vim
