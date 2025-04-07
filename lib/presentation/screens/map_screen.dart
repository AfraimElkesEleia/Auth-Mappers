import 'dart:async';

import 'package:auth_mappers/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:auth_mappers/constants/colors.dart';
import 'package:auth_mappers/constants/strings.dart';
import 'package:auth_mappers/helpers/location_helper.dart';
import 'package:auth_mappers/presentation/components/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

class MapScreen extends StatefulWidget {
  MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // PhoneAuthCubit phoneAuthCubit = PhoneAuthCubit();
  final Completer<GoogleMapController> _mapController = Completer();
  static Position? position;
  final FloatingSearchBarController floatingSearchBarController =
      FloatingSearchBarController();
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

  Widget _buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return FloatingSearchBar(
      controller: floatingSearchBarController,
      hint: 'Find a Place ......',
      border: BorderSide(style: BorderStyle.none),
      hintStyle: TextStyle(fontSize: 18),
      queryStyle: TextStyle(fontSize: 18),
      margins: EdgeInsets.fromLTRB(20, 70, 20, 0),
      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
      iconColor: MyColors.blue,
      scrollPadding: EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: Duration(milliseconds: 600),
      transitionCurve: Curves.easeInOut,
      physics: BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {},
      onFocusChanged: (_) {},
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: Icon(Icons.place, color: MyColors.blue.withOpacity(0.6)),
            onPressed: () {},
          ),
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [],
          ),
        );
      },
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
        drawer: MyDrawer(),
        body: Stack(
          children: [
            position != null
                ? buildMap()
                : Center(
                  child: CircularProgressIndicator(color: Colors.blueAccent),
                ),
            _buildFloatingSearchBar(),
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
