import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:quiz/providers/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:synchronized/synchronized.dart';

enum Status { LOADING, SUCCESS, ERROR, DISABLED }

class LocationResource {
  Status status;
  final LocationData data;
  final String message;

  bool get hasData => data != null;

  LocationResource.success(this.data)
      : status = Status.SUCCESS,
        message = null;

  LocationResource.loading()
      : status = Status.LOADING,
        data = null,
        message = null;

  LocationResource.error(this.message)
      : status = Status.ERROR,
        data = null;

  LocationResource.disabled(this.message)
      : status = Status.DISABLED,
        data = null;
}

class LocationBloc implements Bloc {
  LocationResource lastLocation;

  BehaviorSubject<LocationResource> _locationChanged = BehaviorSubject<LocationResource>();
  BehaviorSubject<LocationResource> _currentLocation = BehaviorSubject<LocationResource>();
  BehaviorSubject<LocationResource> _locationSettings = BehaviorSubject<LocationResource>();


  Stream<LocationResource> get locationChanged => _locationChanged.stream;
  Stream<LocationResource> get notifyCurrentLocation => _currentLocation.stream;
  Stream<LocationResource> get locationSettings => _locationSettings.stream;

  openSettingsMenu() async {
    Location _locationService = Location();
    if (await _locationService.requestService()) {
      LocationData currentLocation = await _locationService.getLocation();

      _locationService.onLocationChanged.listen((LocationData location) {
        currentLocation = location;
      });

      LocationResource _locationResource = LocationResource.success(currentLocation);

      _locationSettings.sink.add(_locationResource);
    } else {
      openSettingsMenu();
      return;
    }
  }

  var lock = new Lock();

  Future<LocationResource> getCurrentLocation() async {
    await lock.synchronized(() async {
      String error;

      print("DRM getCurrentLocation.1");
      if(lastLocation == null){
        try {
          print("DRM getCurrentLocation.2");
          Location location = Location();
          await location.requestPermission();
          print("DRM getCurrentLocation.2.2");
          if (await location.serviceEnabled()) {
            print("DRM getCurrentLocation.3");
            LocationData currentLocation = await location.getLocation();
            print("DRM getCurrentLocation.3.3");
            LocationResource _locationResource = LocationResource.success(currentLocation);
            print("DRM getCurrentLocation.3.4");
            lastLocation = _locationResource;
            _currentLocation.sink.add(_locationResource);
            //return _locationResource;
          } else {
            print("DRM getCurrentLocation.5");
            openSettingsMenu();
          }
        } on PlatformException catch (e) {
          print("DRM getCurrentLocation.6");
          if (e.code == 'PERMISSION_DENIED') {
            print("DRM getCurrentLocation.7");
            error = 'Permission denied';
          } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
            print("DRM getCurrentLocation.8");
            error = 'Permission denied - please ask the user to enable it from the app settings';
          }
          print("DRM getCurrentLocation.9");
          LocationResource _locationResource = LocationResource.error(error);
          _currentLocation.sink.addError(_locationResource);
          //return _locationResource;
        }
      }
    });
    print("DRM getCurrentLocation.11");
    return lastLocation;
  }

  Future<LocationResource> onChangeLocation() async {
    Location location = Location();
    location.onLocationChanged.listen((LocationData currentLocation) {
      lastLocation = LocationResource.success(currentLocation);
      _locationChanged.sink.add(lastLocation);
    });
  }

  void dispose() {
    _currentLocation.close();
    _locationChanged.close();
    _locationSettings.close();
  }

}
