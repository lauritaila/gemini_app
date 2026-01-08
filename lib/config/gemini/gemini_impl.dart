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
}
