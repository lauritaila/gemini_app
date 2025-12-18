import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
User geminiUser(Ref ref) {
  final geminiUser = User(
    id: 'gemini-id',
    firstName: 'Gemini',
    imageUrl: 'https://picsum.photos/id/1005/200/200',
  );
  return geminiUser;
}

@riverpod
User user(Ref ref) {
  final user = User(
    id: 'user',
    firstName: 'laura',
    lastName: "avila",
    imageUrl: 'https://picsum.photos/id/177/200/200',
  );
  return user;
}
