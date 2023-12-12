import 'package:favorite_place/model/place.dart';
import 'package:favorite_place/screens/map_screen.dart';
import 'package:flutter/material.dart';

class PlaceDetailsScreen extends StatelessWidget {
  const PlaceDetailsScreen({Key? key, required this.place}) : super(key: key);
  final Place place;

  String get locationImage {
    final lat = place.placeLocation.lat;
    final lng = place.placeLocation.lng;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng=&zoom=16&size=600x300&maptype=roadmap&markers=color:green%7Clabel:A%7C$lat,$lng&key=AIzaSyDLcwxUggpPZo8lcbH0TB4Crq5SJjtj4ag';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.file(
          place.image,
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => MapScreen(
                              placeLocation: place.placeLocation,
                              isSelecting: false,
                            )));
                  },
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(locationImage),
                    radius: 70,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black54],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                  ),
                  child: Text(
                    textAlign: TextAlign.center,
                    place.placeLocation.address,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                )
              ],
            ))
      ],
    );
  }
}
