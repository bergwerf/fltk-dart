#!/bin/bash

# Copyright (c) 2016, Herman Bergwerf. All rights reserved.
# Use of this source code is governed by a MIT-style license
# that can be found in the LICENSE file.

#DART_SDK=$(which dart | sed 's/.\{9\}$//')
#echo "Found Dart SDK at ${DART_SDK}"
DART_SDK="/usr/lib/dart"
GEN_OUT='ext/src/gen'

# Compile object file.
#
# Notes:
# - add -m32 flag on 32 bit systems.
# - add -g to generate debug info.
function compile {
  g++ -g -std=c++11 -fPIC -I${DART_SDK}/include -DDART_SHARED_LIB -c $1 \
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
      -lfltk_cairo\
  		-lcairo -lpixman-1\
  		-lfltk_gl\
  		-lGLU -lGL\
  		-lfltk\
  		-lXcursor -lXfixes -lXext -lXft -lfontconfig -lXinerama -lpthread -ldl -lm -lX11\
      -o $1.o
}

compile ext/src/main.cpp
compile ext/src/common.c

# Compile individual classes.
for f in {$GEN_OUT/funcs/*.c,$GEN_OUT/wrappers/*.cpp,$GEN_OUT/classes/*.c}
do
  compile $f
done

# Compile shared object.
#
# Notes:
# - add -m32 flag on 32 bit systems.
# - add -g to generate debug info.
gcc -g -shared -Wl,-soname,libfldart.so -o lib/libfldart.so \
    $GEN_OUT/funcs/*.o $GEN_OUT/wrappers/*.o $GEN_OUT/classes/*.o ext/src/*.o \
    -lfltk_cairo\
    -lcairo -lpixman-1\
    -lfltk_gl\
    -lGLU -lGL\
    -lfltk\
    -lXcursor -lXfixes -lXext -lXft -lfontconfig -lXinerama -lpthread -ldl -lm -lX11

# Clean up.
rm $GEN_OUT/{funcs,wrappers,classes}/*.o ext/src/*.o
