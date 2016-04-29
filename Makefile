install:
	# Create symlink for pre-commit hook.
	ln -sf ../../tool/pre-commit.sh .git/hooks/pre-commit

compile-fltk-1.3.3:
	# 1. untar
	mkdir compile
	tar -C ./compile -xvf tar/fltk-1.3.3-source.tar.gz

	# 2. compile
	cd compile/fltk-1.3.3
	make

	# 3. install to /usr/local
	sudo make install

compile-fltk-hello-world:
	/usr/local/bin/fltk-config --compile example/fltk/hello_world.cpp
