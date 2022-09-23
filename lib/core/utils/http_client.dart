import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:quiz_u/core/config/environment.dart';

enum HttpClientMethod { get, post, put, delete }

class HttpClientOptions {
  const HttpClientOptions({
    required this.method,
    required this.endpoint,
    this.body,
    this.headers,
    this.accessToken,
    this.contentType,
  });

  final HttpClientMethod method;
  final String endpoint;
  final Map<String, dynamic>? body;
  final Map<String, String>? headers;
  final String? accessToken;
  final ContentType? contentType;
}

class HttpClient {
  HttpClient({Environment? env}) : environment = env ?? Environment.get();

  final Environment environment;

  Future<Response> request({required HttpClientOptions options}) async {
    final uri = environment.uri.replace(path: options.endpoint);
    final headers = {
      HttpHeaders.acceptHeader: ContentType.json.value,
      HttpHeaders.contentTypeHeader: options.contentType != null
          ? options.contentType!.value
          : ContentType.json.value,
      if (options.headers != null) ...options.headers!,
      if (options.accessToken != null)
        HttpHeaders.authorizationHeader: options.accessToken!,
    };

    print(headers);
    final body = options.body == null ? null : jsonEncode(options.body);
    switch (options.method) {
      case HttpClientMethod.get:
        return get(uri, headers: headers);
      case HttpClientMethod.post:
        return post(uri, headers: headers, body: body);
      case HttpClientMethod.put:
        return put(uri, headers: headers, body: body);
      case HttpClientMethod.delete:
        return delete(uri, headers: headers, body: body);
    }
  }
}
