import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quiz/ui/screens/widgets/custom_google_map.dart';

class MapResultsScreen extends StatefulWidget {
  ValueNotifier<String> findName;

  MapResultsScreen({@required this.findName});

  @override
  _MapResultsState createState() => _MapResultsState();
}

class _MapResultsState extends State<MapResultsScreen> {
  CustomGoogleMap customGoogleMap;

  @override
  void initState() {
    super.initState();
    this.customGoogleMap = CustomGoogleMap();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[Flexible(child: this.customGoogleMap)],
    );
  }
}
