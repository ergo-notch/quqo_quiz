import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quiz/models/model.dart';

class PlacesModel extends Model {
  String nextPageToken;
  String status;
  List<PlaceModel> results;

  PlacesModel();

  @override
  factory PlacesModel.fromJson(Map<String, dynamic> json) {
    PlacesModel places = PlacesModel();
    places.results = List<PlaceModel>();
    if (json['next_page_token'] != null)
      places.nextPageToken = json['next_page_token'];
    places.status = json['status'];
    places.results.addAll((json['results'] as List)
        .map((place) => PlaceModel.fromJson(place))
        .toList());
    if (json['result'] != null)
      places.results.map((place) {
        place.references.addAll((json['result']['photos'] as List)
            .map((detail) => PhotosPlace.fromJson(detail))
            .toList());
      });

    return places;
  }
}

class PlaceModel extends Model {
  LatLng coordenates;
  String icon;
  String placeName;
  String address;
  List<PhotosPlace> references = new List();

  PlaceModel();

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    PlaceModel place = new PlaceModel();
    place.coordenates = new LatLng(json['geometry']['location']['lat'],
        json['geometry']['location']['lng']);
    place.icon = json['icon'];
    place.placeName = json['name'];
    place.address = json['vicinity'];
    place.id = json['id'];
    return place;
  }
}

class PhotosPlace extends Model {
  String photoReference;

  PhotosPlace();

  factory PhotosPlace.fromJson(Map<String, dynamic> json) {
    PhotosPlace photo = new PhotosPlace();
    photo.photoReference = json['photo_reference'];
    return photo;
  }
}
