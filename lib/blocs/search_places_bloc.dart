
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:quiz/providers/bloc.dart';
import 'package:rxdart/rxdart.dart';

class SearchPlacesBloc extends Bloc{

  final BehaviorSubject<PredictionsListView> _subject = new BehaviorSubject();




  @override
  void dispose() {

  }

}