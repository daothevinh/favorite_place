import 'package:favorite_place/model/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen(
      {Key? key,
      this.placeLocation = const PlaceLocation(37.422, -122.084, ''),
      this.isSelecting = true})
      : super(key: key);

  final PlaceLocation placeLocation;
  final bool isSelecting;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;
  bool _selectedPosition = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isSelecting ? 'Pick Your Location' : 'Your Location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
                onPressed: () {
                  if(_selectedPosition) {
                    Navigator.of(context).pop(_pickedLocation);
                  }
                },
                icon: const Icon(Icons.save))
        ],
      ),
      body: GoogleMap(
          initialCameraPosition: CameraPosition(
              target:
                  LatLng(widget.placeLocation.lat, widget.placeLocation.lng),
              zoom: 16),
          onTap: !widget.isSelecting
              ? null
              : (position) {
                  setState(() {
                    _pickedLocation = position;
                    _selectedPosition = true;
                  });
                },
          markers: (_pickedLocation == null && widget.isSelecting)
              ? {}
              : {
                  Marker(
                      markerId: const MarkerId('m1'),
                      position: _pickedLocation ??
                          LatLng(widget.placeLocation.lat,
                              widget.placeLocation.lng)),
                }),
    );
  }
}
