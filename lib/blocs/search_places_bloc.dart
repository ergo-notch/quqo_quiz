import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quiz/models/place_model.dart';
import 'package:quiz/providers/bloc.dart';
import 'package:quiz/utils/connection_manager.dart';
import 'package:quiz/utils/resources.dart';
import 'package:rxdart/rxdart.dart';

class SearchPlacesBloc extends Bloc {
  Repository _repository = Repository();
  final _placesFetcher = PublishSubject<ApiResponse>();

  static final SearchPlacesBloc _singleton = SearchPlacesBloc._internal();

  factory SearchPlacesBloc() {
    return _singleton;
  }

  SearchPlacesBloc._internal();

  Observable<ApiResponse> get places => _placesFetcher.stream;

  fetchPlaces(String name, LatLng coordenates) async {
    ApiResponse apiResponse = await _repository.fetchPlaces(name, coordenates);
    (apiResponse.model as PlacesModel).results.map((place) async {
      ApiResponse detailsResponse = await _repository.getPlaceDetails(place.id);
      (detailsResponse.model as PlacesModel).results.map((photos){
        (apiResponse.model as PlacesModel).results.map((place){
        });
      });
    });

    _placesFetcher.sink.add(apiResponse);
  }

  @override
  void dispose() {
    _placesFetcher.close();
  }
}

class Repository {
  ConnectionManager manager = ConnectionManager();

  Future<ApiResponse> fetchPlaces(String name, LatLng coordenates) =>
      manager.index({
        'key': Constants.googleApiKey,
        'location': coordenates.latitude.toString() +
            ',' +
            coordenates.longitude.toString(),
        'radius': '10000',
        'name': name
      });

  Future<ApiResponse> getPlaceDetails(String placeId) =>
      manager.apiRequest(HttpMethods.GET,{'key': Constants.googleApiKey, 'place_id': placeId},"/api/place/details/json");

  Future<ApiResponse> getPhotoReference(String photoReference) =>
      manager.index({
        'key': Constants.googleApiKey,
        'maxwidth': '400',
        'photoreference': photoReference
      });
}

final searchPlacesBloc = SearchPlacesBloc();
