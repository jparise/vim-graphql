.PHONY: lint lint-help lint-vint test

all: lint test

lint: lint-help lint-vint

lint-help: .bundle/vim-vimhelplint
	vim -esN --not-a-term --cmd 'set rtp+=.bundle/vim-vimhelplint' \
		-c 'filetype plugin on' \
		-c 'e doc/graphql.txt' \
		-c 'verb VimhelpLintEcho' \
		-c q

lint-vint: 
	pip install -q --disable-pip-version-check vim-vint==0.3.21
	vint -s after autoload ftdetect ftplugin indent syntax

test: .bundle/vader.vim .bundle/vim-javascript .bundle/yats.vim
	cd test && vim -EsNu vimrc --not-a-term -c 'Vader! *'

.bundle/vader.vim:
	git clone --depth 1 https://github.com/junegunn/vader.vim.git .bundle/vader.vim

.bundle/vim-javascript:
	git clone --depth 1 https://github.com/pangloss/vim-javascript.git .bundle/vim-javascript

.bundle/vim-vimhelplint:
	git clone --depth 1 https://github.com/machakann/vim-vimhelplint.git .bundle/vim-vimhelplint

.bundle/yats.vim:
	git clone --depth 1 https://github.com/HerringtonDarkholme/yats.vim.git .bundle/yats.vim
