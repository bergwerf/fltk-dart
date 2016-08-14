#!/bin/bash

# Copyright (c) 2016, Herman Bergwerf. All rights reserved.
# Use of this source code is governed by a MIT-style license
# that can be found in the LICENSE file.

mkdir -p ext/src/gen/{core,wrappers,classes}
molviewfmt -c 'Herman Bergwerf' -l 'MIT' -e '**.sh' -e 'compile/**'
make generate-bindings compile-ext
