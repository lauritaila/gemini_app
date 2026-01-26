import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Google gemini'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.pink,
              child: const Icon(Icons.person, color: Colors.white),
            ),
            title: const Text('Basic Prompt'),
            subtitle: const Text('Using a flash model'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () => context.push('/basic-prompt'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child: const Icon(Icons.chat, color: Colors.white),
            ),
            title: const Text('Chat with Context'),
            subtitle: const Text('Using a flash model with context'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () => context.push('/chat-with-context'),
          ),
        ],
      ),
    );
  }
}