#!/bin/bash

# Copyright (c) 2016, Herman Bergwerf. All rights reserved.
# Use of this source code is governed by a MIT-style license
# that can be found in the LICENSE file.

DART_SDK=$(which dart | sed 's/.\{9\}$//')
echo "Found Dart SDK at ${DART_SDK}"

# Compile object file.
#
# Notes:
# - add -m32 flag on 32 bit systems.
# - add -g to generate debug info.
g++ -g -fPIC -I${DART_SDK}/include -DDART_SHARED_LIB -c lib/src/ext/main.cpp \
    -I/usr/include/freetype2 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_THREAD_SAFE -D_REENTRANT \
    -lfltk -lXcursor -lXfixes -lXext -lXft -lfontconfig -lXinerama -lpthread -ldl -lm -lX11 \
    -o libfltk.o

# Compile individual classes.
for f in lib/src/ext/gen/*.cpp
do
  g++ -g -fPIC -I${DART_SDK}/include -DDART_SHARED_LIB -c $f \
      -I/usr/include/freetype2 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_THREAD_SAFE -D_REENTRANT \
      -lfltk -lXcursor -lXfixes -lXext -lXft -lfontconfig -lXinerama -lpthread -ldl -lm -lX11 \
      -o $f.o
done

# Compile shared object.
#
# Notes:
# - add -m32 flag on 32 bit systems.
# - add -g to generate debug info.
gcc -g -shared -Wl,-soname,libfltk.so -o lib/libfltk.so libfltk.o lib/src/ext/gen/*.o \
    -lfltk -lXcursor -lXfixes -lXext -lXft -lfontconfig -lXinerama -lpthread -ldl -lm -lX11

# Clean up.
rm libfltk.o
rm lib/src/ext/gen/*.o
