import 'dart:io';

import 'package:uuid/uuid.dart';

class PlaceLocation {
  const PlaceLocation(this.lat, this.lng, this.address);

  final double lat;
  final double lng;
  final String address;
}

class Place {
  final String title;
  final String id;
  final File image;
  final PlaceLocation placeLocation;

  Place(
      {required this.title,
      required this.image,
      required this.placeLocation,
      String? id})
      : id = id ?? uuid.v4();
}

const uuid = Uuid();
