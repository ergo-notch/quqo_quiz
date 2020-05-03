import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quiz/ui/screens/results_screen.dart';
import 'package:quiz/ui/screens/widgets/searching_text_field.dart';
import 'package:quiz/utils/resources.dart';

import 'map_results_screen.dart';

class SearchPlacesScreen extends StatefulWidget {
  @override
  _SearchPlacesState createState() => _SearchPlacesState();
}

class _SearchPlacesState extends State<SearchPlacesScreen> {
  PlacesTextField placesTextField;
  List<Widget> screens = List();
  int _currentIndex = 0;
  Widget currentScreen;

  @override
  void initState() {
    super.initState();
    var resultsScreen = ResultsScreen(onSelectedPlace: () {});
    screens.add(resultsScreen);
    screens.add(MapResultsScreen());
  }

  @override
  Widget build(BuildContext context) {
//    final locationBloc = BlocProvider.of<LocationBloc>(context);
    return OrientationBuilder(builder: (context, orientation) {
      return Scaffold(
        body: SafeArea(
          child: Column(children: [
            Row(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: placesTextField = PlacesTextField(
                      controller: new TextEditingController(),
                      autoFocus: true,
                      onClearField: () {},
                      onChangeText: (newString) => {}),
                ),
                InkWell(
                    onTap: () {},
                    child: Text(
                      "Buscar",
                      style: TextStyle(color: Colors.redAccent),
                    )),
                SizedBox(
                  width: 10.0,
                )
              ],
            ),
            IndexedStack(
              index: _currentIndex,
              children: screens, //bottomNavigationBar: CupertinoTabBar(
            ),
          ]),
        ),
        bottomNavigationBar: CupertinoTabBar(
          currentIndex: _currentIndex,
          //type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(ImageConstants.resultsIconEnabled,
                  width: 25.0, height: 25.0),
              icon: SvgPicture.asset(ImageConstants.resultsIconDisabled,
                  width: 25.0, height: 25.0),
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(ImageConstants.mapIconEnabled,
                  width: 25.0, height: 25.0),
              icon: SvgPicture.asset(ImageConstants.mapIconDisabled,
                  width: 25.0, height: 25.0),
            )
          ],
          onTap: (index) {
            onTabTapped(index);
          },
        ),
      );
    });
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
