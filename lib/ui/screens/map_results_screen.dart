import 'package:flutter/cupertino.dart';
import 'package:quiz/ui/screens/widgets/custom_google_map.dart';

class MapResultsScreen extends StatefulWidget {
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
      children: <Widget>[this.customGoogleMap],
    );
  }
}
