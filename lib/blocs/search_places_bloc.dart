import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quiz/models/model.dart';
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

  fetchPlaces(String name, LatLng coordenates) {
    PlacesModel result = new PlacesModel();
    _repository.fetchPlaces(name, coordenates).then((response) async {
      result.results = new List();
      await Future.wait(
          (response.model as PlacesModel).results.map((place) async {
        PlaceModel placeModel = place;
        await _repository.getPlaceDetails(placeModel.id).then((apiResponse) {
          PhotosPlace photosPlace = apiResponse.model as PhotosPlace;
          if (photosPlace.placeId == placeModel.id) {
            if (photosPlace.photos != null) {
              placeModel.photos = photosPlace.photos;
            }
            placeModel.placeUrl = photosPlace.placeUrl;
          }
        });
        result.results.add(placeModel);
      }));
      ApiResponse finalResult = new ApiResponse();
      finalResult.model = result;
      _placesFetcher.sink.add(finalResult);
    });
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
        'radius': '1000',
        'keyword': name,
        'name': name
      });

  Future<ApiResponse> getPlaceDetails(String placeId) => manager.apiRequest(
      HttpMethods.GET,
      {'key': Constants.googleApiKey, 'place_id': placeId},
      "/maps/api/place/details/json",
      (json) => PhotosPlace.fromJson(json));
}

final searchPlacesBloc = SearchPlacesBloc();
