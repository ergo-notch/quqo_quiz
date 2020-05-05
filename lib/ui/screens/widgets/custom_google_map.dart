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
  List<Marker> markers = new List();

  CustomGoogleMap(this.markers);

  @override
  _CustomGoogleMapState createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  LocationBloc _locationBloc = LocationBloc();
  LatLng currentLocation;

  double zoomCamera = 16.0;

  _CustomGoogleMapState();

  final Completer<GoogleMapController> mapController = Completer();
  bool isLoading = false;
  BitmapDescriptor myIcon;

  void updateMarkers(List<Marker> markers) {
    setState(() {
      this.widget.markers = markers;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _locationBloc.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController.complete(controller);
    this._currentLocation();
  }

  void _currentLocation() async {
    final GoogleMapController controller = await mapController.future;
    LocationData currentLocation;
    var location = new Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: zoomCamera,
      ),
    ));
  }

  @override
  void initState() {
    locationBloc.getCurrentLocation();
    locationBloc.onChangeLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LocationResource>(
        stream: locationBloc.notifyCurrentLocation,
        initialData: LocationResource.loading(),
        builder: (context, snapshot) {
          return _handleLocation(context, snapshot);
        });
  }

  Widget _handleLocation(
      BuildContext context, AsyncSnapshot<LocationResource> snapshot) {
    if (snapshot.data.status != Status.SUCCESS) {
      return showLoader();
    } else {
      this.currentLocation =
          new LatLng(snapshot.data.data.latitude, snapshot.data.data.longitude);
      return showMap(this.currentLocation);
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
      zoom: zoomCamera,
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
          markers: this.widget.markers.toSet(),
        ));
  }
}
