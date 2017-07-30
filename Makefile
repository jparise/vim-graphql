.PHONY: test

all: test

test: test/vader.vim
	cd test && vim -Nu vimrc -c 'Vader! *' --not-a-term > /dev/null

test/vader.vim:
	git clone --depth 1 https://github.com/junegunn/vader.vim test/vader.vim
