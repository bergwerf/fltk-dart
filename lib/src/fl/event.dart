// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Initiate a Drag And Drop operation.
void dnd() native 'fldart::dnd';

/// Destination for [copy].
enum CopyDestination { selectionBuffer, clipboard }

void _copy(String data, int length, int destination, String mime)
    native 'fldart::copy';

/// Copy [data] with the given [mime] type, into the [destination].
void copy(String data,
        {String mime: 'text/plain',
        CopyDestination destination: CopyDestination.selectionBuffer}) =>
    _copy(data, data.length, destination.index, mime);

/// Get the event text.
String get eventText native 'fldart::eventText';
