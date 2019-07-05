.PHONY: lint test

all: lint test

lint: test/vim-vimhelplint
	vint -s after autoload ftdetect ftplugin indent syntax
	vim -esN --cmd 'set rtp+=test/vim-vimhelplint' \
		-c 'filetype plugin on' \
		-c 'e doc/graphql.txt' \
		-c 'verb VimhelpLintEcho' \
		-c q

test: test/vader.vim test/vim-javascript test/yats.vim
	cd test && vim -Nu vimrc -c 'Vader! *' > /dev/null

test/vader.vim:
	git clone --depth 1 https://github.com/junegunn/vader.vim.git test/vader.vim

test/vim-javascript:
	git clone --depth 1 https://github.com/pangloss/vim-javascript.git test/vim-javascript

test/vim-vimhelplint:
	git clone --depth 1 https://github.com/machakann/vim-vimhelplint.git test/vim-vimhelplint

test/yats.vim:
	git clone --depth 1 https://github.com/HerringtonDarkholme/yats.vim.git test/yats.vim
