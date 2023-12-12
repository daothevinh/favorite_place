import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key, required this.onPickImage}) : super(key: key);
  final Function(File image) onPickImage;
  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? selectedImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
        source: ImageSource.camera, maxWidth: 600);

    if (pickedImage == null) {
      return;
    }
    setState(() {
      selectedImage = File(pickedImage.path);
    });
    widget.onPickImage(selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
        label: const Text('Take Picture'),
        icon: const Icon(Icons.camera),
        onPressed: _takePicture);

    if (selectedImage != null) {
      content = Image.file(
        selectedImage!,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }
    return Container(
        decoration: BoxDecoration(
            border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2))),
        height: 250,
        width: double.infinity,
        alignment: Alignment.center,
        child: content);
  }
}
