import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late String coordinates;

  @override
  void initState() {
    super.initState();
    coordinates = '';
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      setState(() {
        coordinates =
        'Latitude: ${position.latitude}, Longitude: ${position.longitude}\n';
        if (placemarks.isNotEmpty) {
          coordinates +=
          'Address: ${placemarks[0].name}, ${placemarks[0].locality}, ${placemarks[0].country}';
        } else {
          coordinates += 'Address not available';
        }
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AWK's Fitness | Location"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            coordinates,
            style: TextStyle(fontSize: 18.0),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
