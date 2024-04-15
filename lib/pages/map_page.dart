import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tis/main.dart';

// import 'package:mapbox_gl/mapbox_gl.dart';
// import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  final double lat, lon;
  const MapPage({super.key, required this.lat, required this.lon});
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with SingleTickerProviderStateMixin {

  // static const LatLng _pGooglePlex = LatLng(wid, 76.9066717);
  Set<Marker> markers = {};
  
  @override
  Widget build(BuildContext context) {
    markers.add(
      Marker(
        markerId: MarkerId('marker_1'), // Unique identifier for the marker
        position: LatLng(8.5456695, 76.9036853), // Position of the marker
        infoWindow: InfoWindow( // Information shown when marker is tapped
          title: 'Marker Title 1',
          snippet: 'Marker Snippet 1',
        ),
        icon: BitmapDescriptor.defaultMarker, // Icon for the marker (default marker icon)
      ),
    );
    return Scaffold(
      body: GoogleMap(
          initialCameraPosition:
              CameraPosition(target: LatLng(widget.lat,widget.lon), zoom: 17),
              markers: markers,
              ),
            
    );
  }
}
