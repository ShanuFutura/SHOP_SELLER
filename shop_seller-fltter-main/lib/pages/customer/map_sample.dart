import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  LatLng currentLocation;
  Map<MarkerId, Marker> markers;
  MapSample({Key? key, required this.currentLocation, required this.markers})
      : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition? _kGooglePlex;

  // ignore: unnecessary_const
  static const CameraPosition _kLake = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  late GoogleMapController mapController;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  void initState() {
    super.initState();

    _kGooglePlex = CameraPosition(
      target: widget.currentLocation,
      zoom: 14.4746,
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return new Scaffold(
      appBar: AppBar(
        title: Text('Shops nearby'),
      ),
      body: GoogleMap(
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex!,
        markers: widget.markers.values.toSet(),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          mapController = controller;

          final marker = Marker(
            onTap: () {
              print("clicked");
            },
            markerId: const MarkerId('palakkandi'),
            position: const LatLng(37.43296265331129, -122.08832357078792),
            // icon: BitmapDescriptor.,
            infoWindow: const InfoWindow(
              title: 'kora market',
              snippet: 'address',
            ),
          );

          setState(() {
            markers[const MarkerId('palakkandi')] = marker;
          });
        },
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: const Text('To the lake!'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
