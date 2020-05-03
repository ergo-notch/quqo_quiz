import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:quiz/blocs/location_bloc.dart';
import 'package:quiz/utils/resources.dart';
import 'package:quiz/utils/screen_ratio.dart';

//It builds the Gooogle Map on full Screen
class CustomGoogleMap extends StatefulWidget {
  Function(LocationData) currentLocation;

  CustomGoogleMap({this.currentLocation});

  @override
  _CustomGoogleMapState createState() => _CustomGoogleMapState(currentLocation);
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  LocationBloc _locationManager = LocationBloc();
  Function(LocationData) currentLocation;

  Set<Marker> markers;

  _CustomGoogleMapState(this.currentLocation);

  final Completer<GoogleMapController> mapController = Completer();
  bool isLoading = false;
  BitmapDescriptor myIcon;

  Marker mainMarker;
  String _mapStyle;

  @override
  void dispose() {
    super.dispose();
    // _locationBloc.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(_mapStyle);
    mapController.complete(controller);
  }

  void _currentLocation() async {
    final GoogleMapController controller = await mapController.future;
    LocationData currentLocation;
    var location = new Location();
    try {
      currentLocation = await location.getLocation();
      this.currentLocation(currentLocation);
    } on Exception {
      currentLocation = null;
    }

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 17.0,
      ),
    ));
  }

  @override
  void initState() {
//    getCurrentLocationMarker();
    _locationManager.onChangeLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LocationResource>(
        stream: _locationManager.locationChanged.asBroadcastStream(),
        initialData: LocationResource.loading(),
        builder: (context, snapshot) {
          return _handleLocation(context, snapshot);
        });
  }

  Widget _handleLocation(
      BuildContext context, AsyncSnapshot<LocationResource> snapshot) {
    if(snapshot.data.status == Status.LOADING){
      return showLoader();
    }else{
      return showMap(LatLng(0,0));
    }
  }

  showGPSDisableAlert(String message) {
    return Center(child: Text(message));
  }

  Widget showLoader() {
    return Center(child: CircularProgressIndicator());
  }

  Widget showErrorMessage(String message) {
    return Center(child: Text(message));
  }

  Widget showMap(LatLng data) {
    CameraPosition _initialCameraPosition = CameraPosition(
      target: data,
      zoom: 16.5,
    );

    return Scaffold(
        floatingActionButton: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(25 * ScreenRatio.heightRatio))),
          elevation: 5,
          child: IconButton(
            onPressed: _currentLocation,
            icon: Container(
              height: 100.0,
              width: 100.0,
              child: SvgPicture.asset(ImageConstants.currentLocationGet),
            ),
          ),
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
          compassEnabled: false,
          myLocationButtonEnabled: false,
          initialCameraPosition: _initialCameraPosition,
          markers: markers,
        ));
  }

}
