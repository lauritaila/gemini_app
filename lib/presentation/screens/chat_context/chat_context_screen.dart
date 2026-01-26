import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_app/presentation/providers/chat/chat_with_context.dart';
import 'package:gemini_app/presentation/providers/users/user_provider.dart';
import 'package:gemini_app/presentation/widgets/chat/custom_bottom_input.dart';
import 'package:image_picker/image_picker.dart';

class ChatWithContextScreen extends ConsumerWidget {
  const ChatWithContextScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final chatMessages = ref.watch(chatWithContextProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Chat with context'),
      actions: [IconButton(onPressed: (){
        ref.read(chatWithContextProvider.notifier).newChat();
      }, icon: Icon(Icons.clear_rounded))],),
      body: Chat(
        messages: chatMessages,
        onSendPressed: (_) {},
        user: user,
        theme: DarkChatTheme(primaryColor: Colors.pink),
        showUserNames: true,
        //custom input Area
        customBottomWidget: CustomBottomInput(onSend: (types.PartialText partialText, {List<XFile> images = const []}) {
          ref.read(chatWithContextProvider.notifier).addMessage(message: partialText, user: user, images: images);
        }),
      ),
    );
  }
}
