# form-data

Form data builder for Dart.

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