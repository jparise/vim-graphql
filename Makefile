VIM_EXE ?= vim

.PHONY: lint test

all: lint test

lint: .bundle/vim-vimhelplint
	vint -s after autoload ftdetect ftplugin indent syntax
	$(VIM_EXE) -esN --cmd 'set rtp+=.bundle/vim-vimhelplint' \
		-c 'filetype plugin on' \
		-c 'e doc/graphql.txt' \
		-c 'verb VimhelpLintEcho' \
		-c q

test: .bundle/vader.vim .bundle/vim-javascript 
	cd test && $(VIM_EXE) -EsNu vimrc -c 'Vader! * */*'

.bundle/vader.vim:
	git clone --depth 1 https://github.com/junegunn/vader.vim.git .bundle/vader.vim

.bundle/vim-javascript:
	git clone --depth 1 https://github.com/pangloss/vim-javascript.git .bundle/vim-javascript

.bundle/vim-vimhelplint:
	git clone --depth 1 https://github.com/machakann/vim-vimhelplint.git .bundle/vim-vimhelplint
