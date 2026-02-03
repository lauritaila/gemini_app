import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_app/presentation/providers/image/generated_history_provider.dart';
import 'package:gemini_app/presentation/providers/image/selected_image_provider.dart';

class HistoryGrid extends ConsumerWidget {
  const HistoryGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final generatedHistory = ref.watch(generatedHistoryProvider);
    final selectedImage = ref.watch(selectedImageProvider);

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: generatedHistory.length,
      itemBuilder: (context, index) {
        final imageUrl = generatedHistory[index].imageUrl;
        return GestureDetector(
          onTap: () {
            ref.read(selectedImageProvider.notifier).setSelectedImage(imageUrl);
          },
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(
                color: selectedImage == imageUrl ? Colors.blue : Colors.grey,
                width: selectedImage == imageUrl ? 4 : 0,
              ),
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
