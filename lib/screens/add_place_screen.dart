import 'dart:io';

import 'package:favorite_place/model/place.dart';
import 'package:favorite_place/providers/places_provider.dart';
import 'package:favorite_place/widgets/image_input.dart';
import 'package:favorite_place/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  late TextEditingController _titleController;
  File? _selectedImage;
  PlaceLocation? selectedLocation;

  void savePlace() {
    final enteredText = _titleController.text;
    if (enteredText.isEmpty ||
        enteredText == null ||
        _selectedImage == null ||
        selectedLocation == null) {
      return;
    }
    ref
        .read(placesProvider.notifier)
        .addPlace(_titleController.text, _selectedImage!, selectedLocation!);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(children: [
            TextField(
              controller: _titleController,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
              decoration: const InputDecoration(label: Text('Title')),
            ),
            const SizedBox(
              height: 10,
            ),
            ImageInput(onPickImage: (image) {
              _selectedImage = image;
            }),
            const SizedBox(
              height: 10,
            ),
            LocationInput(onSelectLocation: (location) {
              selectedLocation = location;
            }),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: savePlace,
              icon: const Icon(Icons.add),
              label: const Text('Add place'),
            ),
          ]),
        ),
      ),
    );
  }
}
