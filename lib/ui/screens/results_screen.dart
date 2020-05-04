import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quiz/blocs/location_bloc.dart';
import 'package:quiz/blocs/search_places_bloc.dart';
import 'package:quiz/models/place_model.dart';
import 'package:quiz/utils/connection_manager.dart';
import 'package:transparent_image/transparent_image.dart';

class ResultsScreen extends StatefulWidget {
  ValueChanged<PlaceModel> onSelectedPlace;
  ValueNotifier<String> findName;
  Orientation mOrientation = Orientation.portrait;

  ResultsScreen({@required this.findName, @required this.onSelectedPlace});

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<ResultsScreen> {
  @override
  void initState() {
    super.initState();
    locationBloc.getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<LocationResource>(
            stream: locationBloc.notifyCurrentLocation,
            initialData: LocationResource.loading(),
            builder: (context, snapshot) {
              if (snapshot.data.status != Status.SUCCESS) {
                return Center(child: Text('Error al detectar tu ubicación'));
              } else {
                return ValueListenableBuilder(
                    valueListenable: this.widget.findName,
                    builder: (context, value, child) {
                      if (value.toString().isEmpty) {
                        return Center(
                            child: Text(
                                'Comienza a escribir para\n hacer la busqueda'));
                      } else {
                        searchPlacesBloc.fetchPlaces(
                            value,
                            new LatLng(snapshot.data.data.latitude,
                                snapshot.data.data.longitude));
                        return StreamBuilder(
                            stream: searchPlacesBloc.places,
                            builder:
                                (context, AsyncSnapshot<ApiResponse> snapshot) {
                              if (snapshot.hasData) {
                                List<PlaceModel> places =
                                    (snapshot.data.model as PlacesModel)
                                        .results;
                                return GridView.count(
                                    crossAxisCount: 2,
                                    children:
                                        List.generate(places.length, (index) {
                                      PlaceModel place = places[index];
                                      return Card(
                                          margin: EdgeInsets.all(5.0),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: InkWell(
                                              onTap: () {
                                                this
                                                    .widget
                                                    .onSelectedPlace(place);
                                              },
                                              child: _buildItemView(place.icon,
                                                  place.placeName)));
                                    }));
                              } else {
                                return Center(child: Text('Sin Resultados'));
                              }
                            });
                      }
                    });
              }
            }));
  }

  Widget _buildItemView(String urlImage, String placeHolder) {
    return Column(children: [
      FadeInImage.memoryNetwork(
        placeholder: null,
        image: urlImage,
      ),
      Container(
        padding: EdgeInsets.all(5.0),
        child: Text(placeHolder),
      )
    ]);
  }
}
