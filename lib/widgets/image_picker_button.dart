import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:recipe_assistant/providers/app_provider.dart';
import 'package:recipe_assistant/screens/result_screen.dart';

class ImagePickerButton extends StatelessWidget {
  final String label;
  final ImageSource source;

  const ImagePickerButton({super.key, required this.label, required this.source});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(source: source);
        if (pickedFile != null) {
          await Provider.of<AppProvider>(context, listen: false)
              .analyzeImage(pickedFile.path);
          if (!context.mounted) return; // mounted チェックを追加
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ResultScreen()),
          );
        }
      },
      child: Text(label),
    );
  }
}