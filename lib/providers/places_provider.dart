import 'dart:io';

import 'package:favorite_place/model/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class PlacesProvider extends StateNotifier<List<Place>> {
  PlacesProvider() : super([]);

  Future<Database> _getDatabase() async {
    final dbPath = await getDatabasesPath();
    final db = await openDatabase(
      join(dbPath, 'places.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)');
      },
      version: 1,
    );
    return db;
  }

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');
    final places = data
        .map(
          (row) => Place(
            id: row['id'] as String,
            title: row['title'] as String,
            image: File(row['image'] as String),
            placeLocation: PlaceLocation(
              row['lat'] as double,
              row['lng'] as double,
              row['address'] as String,
            ),
          ),
        )
        .toList();

    state = places;
  }

  void addPlace(String title, File image, PlaceLocation placeLocation) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$fileName');

    final newPlace =
        Place(title: title, image: copiedImage, placeLocation: placeLocation);

    final db = await _getDatabase();
    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat': newPlace.placeLocation.lat,
      'lng': newPlace.placeLocation.lng,
      'address': newPlace.placeLocation.address,

    });
    state = [newPlace, ...state];
  }
}

final placesProvider =
    StateNotifierProvider<PlacesProvider, List<Place>>((ref) {
  return PlacesProvider();
});
