import 'package:flutter/cupertino.dart';
import 'package:quiz/ui/screens/login_screen.dart';
import 'package:quiz/ui/screens/place_details_screen.dart';
import 'package:quiz/ui/screens/search_places.dart';

class Navigation {
  static Map get routes => _routes;

  static Map _routes = <String, WidgetBuilder>{
    Routes.signIn: (BuildContext context) => LoginScreen(),
    Routes.searchPlaces: (BuildContext context) => SearchPlacesScreen(),
    Routes.placeDetails: (BuildContext context) => PlaceDetailsScreen(),

  };
}

class Routes {
  static String signIn = '/fbLogin';
  static String searchPlaces = '/searchPlaces';
  static String placeDetails = '/placeDetails';
}