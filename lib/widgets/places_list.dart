import 'package:favorite_place/model/place.dart';
import 'package:favorite_place/screens/place_detail_screen.dart';
import 'package:flutter/material.dart';

class PlaceList extends StatelessWidget {
  const PlaceList({Key? key, required this.places}) : super(key: key);
  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Text('no data',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Theme.of(context).colorScheme.onBackground)),
      );
    }
    return ListView.builder(
        itemCount: places.length,
        itemBuilder: (ctx, index) => ListTile(
              leading: CircleAvatar(
                backgroundImage: FileImage(places[index].image),
              ),
              title: Text(
                places[index].title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(places[index].placeLocation.address,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground)),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => PlaceDetailsScreen(
                          place: places[index],
                        )));
              },
            ));
  }
}
