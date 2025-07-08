import 'dart:convert';
import 'dart:io';

void main() async {
  final server = await HttpServer.bind('localhost', 8080);
  print('Server running on http://${server.address.host}:${server.port}');

  await for (final request in server) {
    try {
      if (request.method == 'POST') {
        final content = await utf8.decoder.bind(request).join();
        await File('dummy.txt').writeAsString(content);
        request.response
          ..statusCode = HttpStatus.ok
          ..write('File written successfully')
          ..close();
      } else if (request.uri.path == '/read') {
        try {
          final content = await File('dummy.txt').readAsString();
          request.response
            ..statusCode = HttpStatus.ok
            ..write(content)
            ..close();
        } catch (e) {
          request.response
            ..statusCode = HttpStatus.notFound
            ..write('File not found')
            ..close();
        }
      } else {
        request.response
          ..statusCode = HttpStatus.notFound
          ..write('Route not found')
          ..close();
      }
    } catch (e) {
      request.response
        ..statusCode = HttpStatus.internalServerError
        ..write('Server error: $e')
        ..close();
    }
  }
}
