import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_assistant/widgets/image_picker_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recipe Assistant')),
      body: Center(
        child: const Column( // const を追加
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImagePickerButton(label: 'Take a Picture', source: ImageSource.camera),
            SizedBox(height: 16),
            ImagePickerButton(label: 'Pick from Gallery', source: ImageSource.gallery),
          ],
        ),
      ),
    );
  }
}