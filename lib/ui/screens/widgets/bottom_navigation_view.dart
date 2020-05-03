import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quiz/utils/resources.dart';

import '../map_results_screen.dart';
import '../results_screen.dart';

class BottomNavigationView extends StatefulWidget {
  VoidCallback onSelectPlace;

  BottomNavigationView({@required this.onSelectPlace});

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigationView> {
  List<Widget> screens = List();
  int _currentIndex = 0;
  Widget currentScreen;

  @override
  void initState() {
    super.initState();
    screens.add(ResultsScreen(onSelectedPlace: () {
      this.widget.onSelectPlace();
    }));
    screens.add(MapResultsScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
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
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
