import 'dart:async';

import 'package:auth_mappers/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:auth_mappers/constants/colors.dart';
import 'package:auth_mappers/constants/strings.dart';
import 'package:auth_mappers/helpers/location_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // PhoneAuthCubit phoneAuthCubit = PhoneAuthCubit();
  final Completer<GoogleMapController> _mapController = Completer();
  static Position? position;
  static final CameraPosition _myCurrentCameraPosition = CameraPosition(
    bearing: 0.0,
    target: LatLng(position!.latitude, position!.longitude),
    tilt: 0.0,
    zoom: 17,
  );
  Future<void> getCurrentLocation() async {
    position = await LocationHelper.detectCurrentLocation().whenComplete(() {
      setState(() {});
    });
    // position = await Geolocator.getLastKnownPosition().whenComplete(() {
    //   setState(() {});
    // });
  }

  Widget buildMap() {
    return GoogleMap(
      initialCameraPosition: _myCurrentCameraPosition,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      mapType: MapType.normal,
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
      },
    );
  }

  Future<void> _gotoMyCurrentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(_myCurrentCameraPosition),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            position != null
                ? buildMap()
                : Center(
                  child: CircularProgressIndicator(color: Colors.blueAccent),
                ),
          ],
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 8, 8),
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            onPressed: _gotoMyCurrentLocation,
            backgroundColor: MyColors.blue,
            child: Icon(Icons.place, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
