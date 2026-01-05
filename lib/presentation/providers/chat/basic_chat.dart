import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:gemini_app/presentation/providers/chat/is_gemini_writing.dart';
import 'package:gemini_app/presentation/providers/users/user_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'basic_chat.g.dart';

@riverpod
class BasicChat extends _$BasicChat {
  @override
  List<Message> build() {
    return [];
  }

  void addMessage({required PartialText message, required User user}) {
    // TODO: implement logic of imgs
    _addTextMessage(message, user);
  }

  void _addTextMessage(PartialText partialText, User author) {
    final message = TextMessage(
      id: const Uuid().v4(),
      author: author,
      text: partialText.text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    state = [message, ...state];
    _geminiTextResponse(partialText.text);
  }

  void _geminiTextResponse(String prompt) async {
    final isGeminiWriting = ref.read(isGeminiWritingProvider.notifier);
    final geminiUser = ref.read(geminiUserProvider);
    isGeminiWriting.setIsGeminiWriting();
    await Future.delayed(const Duration(seconds: 2));
    isGeminiWriting.setNotGeminiWriting();
    final message = TextMessage(
      author: geminiUser,
      id: const Uuid().v4(),
      text: 'This is a response to: $prompt',
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    state = [message, ...state];
  }
}
