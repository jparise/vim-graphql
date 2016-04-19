.PHONY: test

all:

test: test/vader.vim
	cd test && vim -Nu vimrc -c 'Vader! *' > /dev/null

test/vader.vim:
	git clone --depth 1 https://github.com/junegunn/vader.vim test/vader.vim
