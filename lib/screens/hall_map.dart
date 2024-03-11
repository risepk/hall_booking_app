import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HallMap extends StatefulWidget {
  const HallMap({Key? key}) : super(key: key);

  @override
  _HallMapState createState() => _HallMapState();
}

class _HallMapState extends State<HallMap> {
  //late GoogleMapController _controller;
  Set<Marker> _markers = {};
  LatLng? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              if (_selectedLocation != null) {
                // Save _selectedLocation to the database
                // You can implement the API call here
                // Update your database with _selectedLocation.latitude and _selectedLocation.longitude
                print('Selected Location: $_selectedLocation');
              }
            },
          ),
        ],
      ),
      body: GoogleMap(
        mapType: MapType.terrain,
        initialCameraPosition: CameraPosition(
          target: LatLng(37.42796, -122.085749),
          zoom: 14.474,
        ),
        onMapCreated: (GoogleMapController controller) {
          setState(() {
            //_controller = controller;
          });
        },
        markers: _markers,
        onTap: (LatLng latLng) {
          setState(() {
            _selectedLocation = latLng;
            _markers.clear(); // Clear existing markers
            _markers.add(
              Marker(
                markerId: MarkerId("selectedLocation"),
                position: latLng,
                infoWindow: InfoWindow(title: 'Selected Location', snippet: latLng.toString()),
              ),
            );
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){}, //=> _getUserLocation(),
        tooltip: 'Get Current Location',
        child: Icon(Icons.my_location),
      ),
    );
  }

  /*void _getUserLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    LocationData currentLocation = await location.getLocation();
    LatLng userLocation = LatLng(currentLocation.latitude!, currentLocation.longitude!);

    setState(() {
      _selectedLocation = userLocation;
      _markers.clear(); // Clear existing markers
      _markers.add(
        Marker(
          markerId: MarkerId("selectedLocation"),
          position: userLocation,
          infoWindow: InfoWindow(title: 'Selected Location', snippet: userLocation.toString()),
        ),
      );
    });

    // Move the camera to the user's location
    _controller.animateCamera(CameraUpdate.newLatLngZoom(userLocation, 14.0));
  }*/
}
