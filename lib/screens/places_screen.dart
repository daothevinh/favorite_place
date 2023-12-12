import 'package:favorite_place/providers/places_provider.dart';
import 'package:favorite_place/screens/add_place_screen.dart';
import 'package:favorite_place/screens/place_detail_screen.dart';
import 'package:favorite_place/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return PlaceScreenState();
  }
}

class PlaceScreenState extends ConsumerState<PlacesScreen> {
  late Future<void> placesFuture;

  @override
  void initState(){
    super.initState();
    placesFuture = ref.read(placesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final places = ref.watch(placesProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Places'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AddPlaceScreen()));
                },
                icon: const Icon(Icons.add)),
          ],
        ),
        body: FutureBuilder(
            future: placesFuture,
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : PlaceList(places: places)));
  }
}
