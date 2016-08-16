install-hook:
	# Create symlink for pre-commit hook.
	ln -sf ../../tool/pre-commit.sh .git/hooks/pre-commit

generate-bindings:
	# Don't use a directory regex or ZSH will start asking confirmations.
	rm -f ext/src/gen/classes/* ext/src/gen/funcs/* ext/src/gen/wrappers/*
	mkdir -p ext/src/gen/classes ext/src/gen/funcs ext/src/gen/wrappers
	dart tool/codegen/generate.dart

fltk_version = "1.3.3"
compile-fltk:
	# 1. untar
	mkdir -p compile
	rm -rf compile/fltk-${fltk_version}
	tar -C ./compile -xvf tar/fltk-${fltk_version}-source.tar.gz

	# 2. Enable ABI version 103030
	sed -i 's/\/\/#define FLTK_ABI_VERSION 10303/#define FLTK_ABI_VERSION 10303/g' compile/fltk-1.3.3/FL/Enumerations.H

	# 3. compile
	cd compile/fltk-${fltk_version}; ./configure --enable-cairo --enable-shared --enable-debug; make; sudo make install

	# 4. reconfigure dynamic linker run-time bindings
	sudo ldconfig

compile-ext:
	./tool/compile-ext.sh

compile-example:
	#g++ example/${name}.cpp `fltk-config --use-gl --cxxflags` `fltk-config --use-gl --ldflags`
	g++ \
		-std=c++11\
		-I/usr/local/include\
		-I/usr/include/cairo\
		-I/usr/include/glib-2.0\
		-I/usr/include/pixman-1\
		-I/usr/include/freetype2\
		-I/usr/include/libpng12\
		-I/usr/local/include/FL/images\
		-I/usr/include/freetype2\
		-fvisibility-inlines-hidden\
		-D_LARGEFILE_SOURCE\
		-D_LARGEFILE64_SOURCE\
		-D_THREAD_SAFE\
		-D_REENTRANT\
		-o 'binary' "example/${name}.cpp"\
		/usr/local/lib/libfltk_cairo.a\
		-lcairo -lpixman-1\
		/usr/local/lib/libfltk_gl.a\
		-lGLU -lGL\
		/usr/local/lib/libfltk.a\
		-lXcursor -lXfixes -lXext -lXft -lfontconfig -lXinerama -lpthread -ldl -lm -lX11
	./binary
	rm binary

	# Compiling using FLTK helper binary.
	#fltk-config --use-gl --use-cairo --compile example/${name}.cpp
	#./${name}
	#rm ${name}
