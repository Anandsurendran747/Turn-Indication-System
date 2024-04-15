import 'package:flutter/material.dart';
import 'package:tis/pages/MapScreen.dart';
import 'package:tis/pages/map_page.dart';
import 'package:geolocator/geolocator.dart';

// void getLocationPermission() async {
//   Location location = Location();
//   bool _serviceEnabled;
//   PermissionStatus _permissionGranted;

//   _serviceEnabled = await location.serviceEnabled();
//   if (!_serviceEnabled) {
//     _serviceEnabled = await location.requestService();
//     if (!_serviceEnabled) {
//       return;
//     }
//   }

//   _permissionGranted = await location.hasPermission();
//   if (_permissionGranted == PermissionStatus.denied) {
//     _permissionGranted = await location.requestPermission();
//     if (_permissionGranted != PermissionStatus.granted) {
//       return;
//     }
//   }
// }
double lat = 8.5454576, lon = 76.9032838;
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  print("enteeredddd......");
  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  print(serviceEnabled);
  if (!serviceEnabled) {
    print("disaled..");
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    print("denied..");
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      print("denied..");
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  Position p = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
  print('Location....................${p.latitude}');
  lat = await p.latitude;
  lon = await p.longitude;

  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
}

void getLocation() async {}

main() {
  // getLocationPermission();
  // Location location = Location();

  // location.onLocationChanged.listen((LocationData currentLocation) {
  //   print(
  //       'haiiiiiiiiiiii${currentLocation.latitude}, ${currentLocation.longitude}');
  // });

  // (() async {
  //   print("dummmyyyyyyyyyyy.............");
  //   Position position = await _determinePosition();
  //   print('Location....................${position}');
  //   // After the asynchronous operation completes, run the Flutter app
  // })();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    print("Building MyHomePage widget");
    return MaterialApp(
      title: 'TIM',
      theme: ThemeData(primaryColor: Colors.indigo),
      home: LocationCheck(),
    );
  }
}

class LocationCheck extends StatelessWidget {
  Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<bool> checkLocationService() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      // Location service is enabled, try to get the current position
      try {
        await getCurrentPosition();
        return true; // Return true if current position is obtained
      } catch (e) {
        print("Error getting position: $e");
        return false; // Return false if there's an error getting the position
      }
    } else {
      return false; // Return false if location service is not enabled
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkLocationService(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          final bool locationServiceEnabled = snapshot.data ?? false;
          if (snapshot.hasError || !locationServiceEnabled) {
            // If there's an error or location service is not enabled
            return Scaffold(
              body: Center(
                child: Text('Location service is not enabled'),
              ),
            );
          } else {
            // If location service is enabled and current position is obtained

            return Scaffold(
              body: Center(
                child: MapPage(
                  lat: lat,
                  lon: lon,
                ),
              ),
            );
          }
        }
      },
    );
  }
}
