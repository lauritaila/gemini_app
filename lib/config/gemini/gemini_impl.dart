import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiImpl {
  final Dio _dio = Dio(BaseOptions(baseUrl: dotenv.env['ENDPOINT_API'] ?? ''));
  Future<String> getResponse(String prompt) async {
    try {
      final body = jsonEncode({'prompt': prompt});
      final response = await _dio.post('/basic-prompt', data: body);
      return response.data;
    } catch (e) {
      print(e);
      return 'Error: Could not get response from Gemini.';
    }
  }
  Stream<String> getResponseStream(String prompt) async* {
    //TODO: IMPLEMENT IMGS LOGIC
    //! MULTIPART REQUEST
    try {
      final body = jsonEncode({'prompt': prompt});

      final response = await _dio.post(
        '/basic-prompt-stream',
        data: body,
        options: Options(responseType: ResponseType.stream),
      );

      final stream = response.data.stream as Stream<List<int>>;
      String buffer = "";

      await for (var chunk in stream) {
        final chunkString = utf8.decode(chunk, allowMalformed: true);
        buffer += chunkString;
        yield buffer;
      }

    } catch (e) {
      print(e);
      yield 'Error: Could not get response from Gemini.';
    }
  }
}
