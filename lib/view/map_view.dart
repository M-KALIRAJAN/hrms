import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hrms/services/Location_Service.dart';
import 'package:hrms/services/PunchService.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double? latitude;
  double? longitude;
  late GoogleMapController mapController;
 final PunchService _punchService = PunchService();
  @override
  void initState() {
    super.initState();
    getLocationAndSend();
  }

  void getLocationAndSend() async {
    try {
      final position = await LocationService.getCurrentLocation();

      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
      });

      // Move camera to current location
      mapController.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(position.latitude, position.longitude),
        ),
      );

    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Latitude: ${latitude ?? 'Loading...'}"),
          Text("Longitude: ${longitude ?? 'Loading...'}"),
          Container(
            height: 500,
            child: (latitude != null && longitude != null)
                ? GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(latitude!, longitude!),
                      zoom: 15,
                    ),
                    myLocationEnabled: true,
                    onMapCreated: (controller) {
                      mapController = controller;
                    },
                  )
                : Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
