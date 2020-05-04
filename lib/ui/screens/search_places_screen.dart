import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/ui/screens/widgets/bottom_navigation_view.dart';
import 'package:quiz/ui/screens/widgets/searching_text_field.dart';
import 'package:quiz/utils/routes.dart';
import 'package:quiz/utils/screen_ratio.dart';

class SearchPlacesScreen extends StatefulWidget {
  @override
  _SearchPlacesState createState() => _SearchPlacesState();
}

class _SearchPlacesState extends State<SearchPlacesScreen> {
  PlacesTextField placesTextField;

  ValueNotifier<String> valueNotifier = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    ScreenRatio.setScreenRatio(queryData.size.height, queryData.size.width,
        queryData.devicePixelRatio);
//    final locationBloc = BlocProvider.of<LocationBloc>(context);
    return OrientationBuilder(builder: (context, orientation) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: placesTextField = PlacesTextField(
                        controller: new TextEditingController(),
                        autoFocus: true,
                        onClearField: () {},
                        onChangeText: (newString) {
                          valueNotifier.value = newString;
                        }),
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
              Flexible(
                child: BottomNavigationView(
                    onSelectPlace: (place) {
                      Navigator.pushNamed(context, Routes.placeDetails,
                          arguments: place);
                    },
                    findName: this.valueNotifier),
              )
            ]),
          ));
    });
  }
}
