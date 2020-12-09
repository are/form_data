# <center>🧾 `package:form_data`</center>

[![Pub Version](https://img.shields.io/pub/v/form_data)](https://pub.dev/packages/form_data)
[![RFC](https://img.shields.io/badge/RFC-7578-blue)](https://tools.ietf.org/html/rfc7578)

`Content-Type: multipart/form-data` builder for Dart aiming to be compatible with [RFC 7578](https://tools.ietf.org/html/rfc7578).

API documentation is available [here](https://pub.dev/documentation/form_data/latest/).


## Installation

Add `form_data` to your `pubspec.yaml` and run `pub get` or `flutter pub get`.

```yaml
dependencies:
  form_data: ^0.0.1-nullsafety.0
```

## Usage

Instantinate `FormData` class and add fields using `add` and `addFile` methods.

```dart
var formData = FormData();

formData.add('name', 'Name Surname');
formData.add('answer', 42);
formData.addFile('file', await File('picture.png').readAsBytes(),
  filename: 'myPicture.png', contentType: 'image/png');
```

Extract data using `body`, `contentType` and `contentLength` headers.

```dart
var request = client.postUrl(myUri);

request.headers.set('Content-Type', formData.contentType);
request.headers.set('Content-Length', formData.contentLength);

request.add(formData.body);

await request.close();
```