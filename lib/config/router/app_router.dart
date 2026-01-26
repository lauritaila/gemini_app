

import 'package:gemini_app/presentation/screens/chat_context/chat_context_screen.dart';
import 'package:gemini_app/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/basic-prompt',
      builder: (context, state) => const BasicPromptScreen(),
    ),
    GoRoute(
      path: '/chat-with-context',
      builder: (context, state) => const ChatWithContextScreen(),
    ),
  ],
);