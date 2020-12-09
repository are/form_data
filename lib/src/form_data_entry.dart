import 'dart:convert';

class FormDataEntry {
  static const String defaultContentType = 'application/octet-stream';

  final String name;
  final List<int> value;

  final String contentType;
  final String filename;

  FormDataEntry._(this.name, this.value, {this.filename, this.contentType});

  factory FormDataEntry.fromBytes(String name, List<int> bytes,
      {String contentType = FormDataEntry.defaultContentType,
      String filename}) {
    return FormDataEntry._(name, bytes,
        contentType: contentType, filename: filename);
  }

  factory FormDataEntry.fromString(String name, String value,
      {Encoding encoding = utf8, String contentType, String filename}) {
    return FormDataEntry._(name, encoding.encode(value),
        contentType: contentType, filename: filename);
  }
}
