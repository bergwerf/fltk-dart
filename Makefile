install-hook:
	# Create symlink for pre-commit hook.
	ln -sf ../../tool/pre-commit.sh .git/hooks/pre-commit

generate-bindings:
	dart tool/codegen/generate.dart

compile-fltk-1.3.3:
	# 1. untar
	mkdir -p compile
	rm -rf compile/fltk-1.3.3
	tar -C ./compile -xvf tar/fltk-1.3.3-source.tar.gz

	# 2. compile
	cd compile/fltk-1.3.3; ./configure --enable-shared --enable-debug; make; sudo make install

compile-fltk-ext:
	./tool/compile-ext.sh

run-fltk-example:
	g++ example/${name}.cpp \
		-I/usr/include/freetype2 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_THREAD_SAFE -D_REENTRANT \
		-lfltk -lXcursor -lXfixes -lXext -lXft -lfontconfig -lXinerama -lpthread -ldl -lm -lX11
	# g++ example/${name}.cpp `fltk-config --cxxflags` `fltk-config --ldflags`
	# /usr/local/bin/fltk-config --compile example//${name}.cpp
	./a.out
	rm a.out
