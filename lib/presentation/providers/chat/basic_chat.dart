// ignore_for_file: unused_element

import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:gemini_app/config/gemini/gemini_impl.dart';
import 'package:gemini_app/presentation/providers/chat/is_gemini_writing.dart';
import 'package:gemini_app/presentation/providers/users/user_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'basic_chat.g.dart';

@riverpod
class BasicChat extends _$BasicChat {
  final gemini = GeminiImpl();
  late User geminiUser;

  @override
  List<Message> build() {
    geminiUser = ref.read(geminiUserProvider);
    return [];
  }

  void addMessage({required PartialText message, required User user, List<XFile> images = const []}) {
    if (images.isNotEmpty) {
      _addTextMessageWithImages(images, user, message);
      return;
    }
    _addTextMessage(message, user);
  }

  void _addTextMessage(PartialText partialText, User author) {
    _createTextMessage(partialText.text, author);
    // _geminiTextResponse(partialText.text);
    _geminiTextResponseStream(partialText.text);
  }

  void _addTextMessageWithImages(List<XFile> images, User author, PartialText partialText) async{
    for (XFile image in images) {
      _createImageMessage(image, author);
    }
    await Future.delayed(const Duration(milliseconds: 50));
    _createTextMessage(partialText.text, author);
    _geminiTextResponseStream(partialText.text, images: images);

  }

  void _geminiTextResponse(String prompt) async {
    _setGeminiWritingStatus(true);
    final resp = await gemini.getResponse(prompt);
    _setGeminiWritingStatus(false);
    _createTextMessage(resp, geminiUser);
  }

  void _geminiTextResponseStream(String prompt,{List<XFile> images = const []}) async {

    _createTextMessage('Gemini is thinking...', geminiUser);
    gemini.getResponseStream(prompt, files: images).listen((responseChunk) {
      if(responseChunk.isEmpty) return;
      final updatedMessages = [...state];
      final updatedMessage = (updatedMessages.first as TextMessage).copyWith(text: responseChunk);

      if (updatedMessages.isNotEmpty) {
        updatedMessages[0] = updatedMessage;
        state = updatedMessages;
      }
    });
  }

  //Helpers methods
  void _setGeminiWritingStatus(bool isWriting) {
    final isGeminiWriting = ref.read(isGeminiWritingProvider.notifier);
    isWriting
        ? isGeminiWriting.setIsGeminiWriting()
        : isGeminiWriting.setNotGeminiWriting();
  }

  void _createTextMessage(String text, User author) {
    final message = TextMessage(
      id: const Uuid().v4(),
      author: author,
      text: text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    state = [message, ...state];
  }

  void _createImageMessage(XFile image, User author) async{
    final message = ImageMessage(
      id: const Uuid().v4(),
      author: author,
      uri: image.path,
      name: image.name,
      size: await image.length(),
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    state = [message, ...state];
  }
}
