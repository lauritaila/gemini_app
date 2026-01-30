import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';

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

  Stream<String> getResponseStream(
    String prompt, {
    List<XFile> files = const [],
  }) async* {
    yield* _getStreamedResponse(
      prompt: prompt,
      endpoint: '/basic-prompt-stream',
      files: files,
    );
  }

  Stream<String> getChatStream(
    String prompt, 
    String chatId,
    {
    List<XFile> files = const [],
  }) async* {
    yield* _getStreamedResponse(
      prompt: prompt,
      endpoint: '/chat-stream',
      formFields: {'chat_id': chatId},
      files: files,
    );
  }

  //emmit stream if information
  Stream<String> _getStreamedResponse({
    required String prompt,
    required String endpoint,
    Map<String, dynamic> formFields = const {},
    List<XFile> files = const [],
  }) async* {
    try {

      final formData = FormData();
      formData.fields.add(MapEntry('prompt', prompt));
      for(final entry in formFields.entries){
        formData.fields.add(MapEntry(entry.key, entry.value));
      }

      if (files.isNotEmpty) {
        for (XFile file in files) {
          formData.files.add(
            MapEntry(
              'files',
              await MultipartFile.fromFile(file.path, filename: file.name),
            ),
          );
        }
      }

      final response = await _dio.post(
        endpoint,
        data: formData,
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
      yield 'Error: Could not get response from Gemini.';
    }
  }

   Future<String?> generateImage(String prompt, {List<XFile> files = const []}) async {
    final formData = FormData();
    formData.fields.add(MapEntry('prompt', prompt));

    if (files.isNotEmpty) {
      for (XFile file in files) {
        formData.files.add(
          MapEntry(
            'files',
            await MultipartFile.fromFile(file.path, filename: file.name),
          ),
        );
      }
    }

    try {
      final response = await _dio.post(
        '/image-generation',
        data: formData,
      );
      return response.data['imageUrl'];
    } catch (e) {
      print(e);
      return null;
    }
  }
}
