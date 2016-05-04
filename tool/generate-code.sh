#!/bin/bash

# Copyright (c) 2016, Herman Bergwerf. All rights reserved.
# Use of this source code is governed by a MIT-style license
# that can be found in the LICENSE file.

regex='lib/api/(.*)/(.*).yaml'
for f in lib/api/**/*.yaml
do
  if [[ $f =~ $regex ]]
  then
    #echo $f
    mustache $f lib/api/templates/${BASH_REMATCH[1]}/header.mustache > lib/src/ext/gen/${BASH_REMATCH[2]}.hpp
    mustache $f lib/api/templates/${BASH_REMATCH[1]}/source.mustache > lib/src/ext/gen/${BASH_REMATCH[2]}.cpp
  fi
done
