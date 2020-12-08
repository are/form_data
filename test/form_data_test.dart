import 'dart:convert';
import 'dart:io';

import 'package:form_data/form_data.dart';
import 'package:test/test.dart';

void main() {
  group('FormData encoder', () {
    test('works correctly with primitive data types', () async {
      var formData = FormData();

      formData.boundary = '---123';

      formData.add('name', 'Fisrtname McSurname');
      formData.add('age', 10);
      formData.add('address', '''some longer
        value with new lines and emojis 😃''');

      formData.addFile('image', await File('test/input.jpeg').readAsBytes(),
          filename: 'myImage.jpeg', contentType: 'image/jpeg');

      var expected = await File('test/result.bin').readAsBytes();

      expect(formData.body, equals(expected));
    });
  });
}
