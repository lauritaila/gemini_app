// ignore_for_file: unused_element

import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:gemini_app/config/gemini/gemini_impl.dart';
import 'package:gemini_app/presentation/providers/users/user_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'chat_with_context.g.dart';

@Riverpod(keepAlive: true)
class ChatWithContext extends _$ChatWithContext {
  final gemini = GeminiImpl();
  late User geminiUser;
  late String chatId;

  @override
  List<Message> build() {
    geminiUser = ref.read(geminiUserProvider);
    chatId = const Uuid().v4();
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

  void _geminiTextResponseStream(String prompt,{List<XFile> images = const []}) async {

    _createTextMessage('Gemini is thinking...', geminiUser);
    gemini.getChatStream(prompt,chatId, files: images).listen((responseChunk) {
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
  void newChat(){
    chatId = const Uuid().v4();
    state = [];
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
