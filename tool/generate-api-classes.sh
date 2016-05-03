#!/bin/bash

# Copyright (c) 2016, Herman Bergwerf. All rights reserved.
# Use of this source code is governed by a MIT-style license
# that can be found in the LICENSE file.

regex='lib/api/(.*).yaml'
for f in lib/api/*.yaml
do
  if [[ $f =~ $regex ]]
  then
    mustache lib/api/${BASH_REMATCH[1]}.yaml lib/api/templates/header.mustache > lib/src/ext/gen/${BASH_REMATCH[1]}.hpp
    mustache lib/api/${BASH_REMATCH[1]}.yaml lib/api/templates/source.mustache > lib/src/ext/gen/${BASH_REMATCH[1]}.cpp
  fi
done
