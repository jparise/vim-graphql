.PHONY: test

all: test

test: test/vader.vim test/vim-javascript
	cd test && vim -Nu vimrc -c 'Vader! *' > /dev/null

test/vader.vim:
	git clone --depth 1 https://github.com/junegunn/vader.vim.git test/vader.vim

test/vim-javascript:
	git clone --depth 1 https://github.com/pangloss/vim-javascript.git test/vim-javascript
