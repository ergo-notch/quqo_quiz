import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultsScreen extends StatefulWidget {
  VoidCallback onSelectedPlace;

  ResultsScreen({@required onSelectedPlace});

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<ResultsScreen> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (context, orientation) {
          return GridView.count(
              crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
              children: List.generate(10, (index) {
                return Center(
                    child: Text(
                      'Item $index',
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline,
                    ));
              }));
        });
  }
}
