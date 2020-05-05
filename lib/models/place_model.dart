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
    if (json['results'] != null)
      places.results.addAll((json['results'] as List)
          .map((place) => PlaceModel.fromJson(place))
          .toList());

    return places;
  }
}

class PlaceModel extends Model {
  LatLng coordenates;
  String icon;
  String placeName;
  String address;
  List<String> photos = new List();
  String placeUrl;

  PlaceModel();

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    PlaceModel place = new PlaceModel();
    place.coordenates = new LatLng(json['geometry']['location']['lat'],
        json['geometry']['location']['lng']);
    place.icon = json['icon'];
    place.placeName = json['name'];
    place.address = json['vicinity'];
    place.id = json['place_id'];
    return place;
  }
}

class PhotosPlace extends Model {
  List<String> photos = new List<String>();
  String placeId;
  String placeUrl;

  PhotosPlace();

  factory PhotosPlace.fromJson(Map<String, dynamic> json) {
    PhotosPlace photo = new PhotosPlace();
    List<String> photos = new List<String>();
    if (json['result'] != null) {
      // ignore: unnecessary_statements
      ((json['result']['photos'] as List)
          .forEach((detail) => photos.add(detail['photo_reference'])));
      photo.placeId = json['result']['place_id'];
      photo.placeUrl = json['result']['url'];
    }
    photo.photos = photos;
    return photo;
  }
}
