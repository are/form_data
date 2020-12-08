import 'dart:math';
import 'dart:convert';

import 'package:form_data/src/form_data_entry.dart';

String _generateBoundary() {
  var random = Random();

  var boundary = '--------------------------';

  for (var i = 0; i < 24; i++) {
    boundary += random.nextInt(10).toString();
  }

  return boundary;
}

const _LB = '\r\n';

/// Used to generate form data.
class FormData {
  /// Encoding used in converting [String] to [List<int>]. Defaults to `utf8`.
  final Encoding encoding;
  final List<FormDataEntry> _entries = [];

  /// Boundary used in the form data.
  String boundary = _generateBoundary();

  String get _midBoundary => '--${boundary}${_LB}';
  String get _endBoundary => '--${boundary}--${_LB}';

  FormData({this.encoding = utf8});

  /// Add a field [name] to the form data.
  ///
  /// [value] will be converted to a string using [Object.toString] and encoded using [FormData.encoding].
  void add(String name, dynamic value,
      {String? contentType, String? filename}) {
    _entries.add(FormDataEntry.fromString(name, value.toString(),
        contentType: contentType, filename: filename, encoding: encoding));
  }

  /// Add a field [name] to the form data.
  ///
  /// [contents] will be added directly to the body, skipping encoding.
  void addFile(String name, List<int> contents,
      {String? contentType, String? filename}) {
    _entries.add(FormDataEntry.fromBytes(name, contents,
        filename: filename, contentType: contentType));
  }

  /// Content type header including the boundary.
  String get contentType => 'multipart/form-data; boundary=${boundary}';

  /// Length of the content.
  int get contentLength => body.length;

  /// Body of the form data.
  List<int> get body {
    var _body = <int>[];

    for (var entry in _entries) {
      _body.addAll(encoding.encode(_midBoundary));
      _body.addAll(encoding
          .encode('Content-Disposition: form-data; name="${entry.name}"'));

      if (entry.filename != null) {
        _body.addAll(encoding.encode('; filename="${entry.filename}"'));
      }

      _body.addAll(encoding.encode(_LB));

      if (entry.contentType != null) {
        _body.addAll(
            encoding.encode('Content-Type: ${entry.contentType}${_LB}'));
      }

      _body.addAll(encoding.encode(_LB));
      _body.addAll(entry.value);
      _body.addAll(encoding.encode(_LB));
    }

    _body.addAll(encoding.encode(_endBoundary));

    return _body;
  }
}
