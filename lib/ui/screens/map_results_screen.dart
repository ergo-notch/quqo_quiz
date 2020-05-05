import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quiz/blocs/location_bloc.dart';
import 'package:quiz/blocs/search_places_bloc.dart';
import 'package:quiz/models/place_model.dart';
import 'package:quiz/ui/screens/widgets/custom_google_map.dart';

class MapResultsScreen extends StatefulWidget {
  ValueNotifier<String> findName;

  MapResultsScreen({@required this.findName});

  @override
  _MapResultsState createState() => _MapResultsState();
}

class _MapResultsState extends State<MapResultsScreen> {
  CustomGoogleMap customGoogleMap = CustomGoogleMap(new List());

  @override
  void initState() {
    super.initState();
    locationBloc.getCurrentLocation().then((currenLocation) {
      if (currenLocation.status == Status.SUCCESS) {
        this.widget.findName.addListener(() {
          searchPlacesBloc.fetchPlaces(
              this.widget.findName.value,
              new LatLng(
                  currenLocation.data.latitude, currenLocation.data.longitude));
        });
      }
    });
    searchPlacesBloc.places.listen((result) {
      if (result.model is PlacesModel) {
        setState(() {
          this.customGoogleMap = CustomGoogleMap(
              this.generateMarkers((result.model as PlacesModel).results));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[Flexible(child: this.customGoogleMap)],
    );
  }

  List<Marker> generateMarkers(List<PlaceModel> places) {
    List<Marker> result = new List<Marker>();
    places.forEach((place) {
      Marker marker =
          Marker(markerId: MarkerId(place.id), position: place.coordenates);
      result.add(marker);
    });
    return result;
  }
}
