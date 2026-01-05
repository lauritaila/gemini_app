import 'package:flutter_chat_types/flutter_chat_types.dart';
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
    state = [message,...state];
  }

}