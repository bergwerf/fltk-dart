#!/bin/bash

# Copyright (c) 2016, Herman Bergwerf. All rights reserved.
# Use of this source code is governed by a MIT-style license
# that can be found in the LICENSE file.

DART_SDK=$(which dart | sed 's/.\{9\}$//')
echo "Found Dart SDK at ${DART_SDK}"
GEN_OUT='ext/src/gen'

# Compile object file.
#
# Notes:
# - add -m32 flag on 32 bit systems.
# - add -g to generate debug info.
function compile {
  g++ -g -std=c++11 -fPIC -I${DART_SDK}/include -DDART_SHARED_LIB -c $1 \
      -I/usr/include/freetype2 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_THREAD_SAFE -D_REENTRANT \
      -lfltk -lXcursor -lXfixes -lXext -lXft -lfontconfig -lXinerama -lpthread -ldl -lm -lX11 \
      -o $1.o
}

compile ext/src/main.cpp
compile ext/src/common.cpp

# Compile individual classes.
for f in {$GEN_OUT/core/*.cpp,$GEN_OUT/wrappers/*.cpp,$GEN_OUT/widgets/*.cpp}
do
  compile $f
done

# Compile shared object.
#
# Notes:
# - add -m32 flag on 32 bit systems.
# - add -g to generate debug info.
gcc -g -shared -Wl,-soname,libfltk.so -o lib/libfltk.so \
    $GEN_OUT/core/*.o $GEN_OUT/wrappers/*.o $GEN_OUT/widgets/*.o ext/src/*.o \
    -lfltk -lXcursor -lXfixes -lXext -lXft -lfontconfig -lXinerama -lpthread -ldl -lm -lX11

# Clean up.
rm $GEN_OUT/{core,wrappers,widgets}/*.o ext/src/*.o
