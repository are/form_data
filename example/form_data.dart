import 'dart:io';

import 'package:form_data/form_data.dart';

void main() {
  var formData = FormData()
    ..add('field name', 'value')
    ..add('primitive types', 42)
    ..addFile('my file', File(Platform.script.path).readAsBytesSync(),
        filename: 'form_data.dart');

  print(formData.contentType);
  print(formData.contentLength);
  print(formData.body);
}
