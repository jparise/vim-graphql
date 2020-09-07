.PHONY: lint test

all: lint test

lint: .bundle/vim-vimhelplint
	vint -s after autoload ftdetect ftplugin indent syntax
	vim -esN --not-a-term --cmd 'set rtp+=.bundle/vim-vimhelplint' \
		-c 'filetype plugin on' \
		-c 'e doc/graphql.txt' \
		-c 'verb VimhelpLintEcho' \
		-c q

test: .bundle/vader.vim .bundle/vim-javascript 
	cd test && vim -EsNu vimrc --not-a-term -c 'Vader! * */*'

.bundle/vader.vim:
	git clone --depth 1 https://github.com/junegunn/vader.vim.git .bundle/vader.vim

.bundle/vim-javascript:
	git clone --depth 1 https://github.com/pangloss/vim-javascript.git .bundle/vim-javascript

.bundle/vim-vimhelplint:
	git clone --depth 1 https://github.com/machakann/vim-vimhelplint.git .bundle/vim-vimhelplint
