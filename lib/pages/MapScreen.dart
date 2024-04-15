import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Polyline> _polylines = {};

  static final LatLng _destinationLocation = LatLng(37.422, -122.084); // Default destination
  late LatLng _currentLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _getDirections() {
    // Fetch directions and decode polyline
    // Here, I'm just adding a mock polyline for demonstration
    List<LatLng> polylineCoordinates = [
      LatLng(_currentLocation.latitude, _currentLocation.longitude),
      _destinationLocation,
    ];

    setState(() {
      _polylines.add(Polyline(
        polylineId: PolylineId('route'),
        points: polylineCoordinates,
        color: Colors.blue,
        width: 3,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _currentLocation ?? _destinationLocation,
              zoom: 15,
            ),
            polylines: _polylines,
            markers: {
              if (_currentLocation != null)
                Marker(
                  markerId: MarkerId('current_location'),
                  position: _currentLocation,
                  infoWindow: InfoWindow(title: 'Your Location'),
                ),
              Marker(
                markerId: MarkerId('destination_location'),
                position: _destinationLocation,
                infoWindow: InfoWindow(title: 'Destination'),
              ),
            },
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: ElevatedButton(
              onPressed: _getDirections,
              child: Text('Get Directions'),
            ),
          ),
        ],
      ),
    );
  }
}
