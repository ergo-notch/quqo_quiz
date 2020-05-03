import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/blocs/login_bloc.dart';
import 'package:quiz/providers/bloc_provider.dart';
import 'package:quiz/utils/resources.dart';
import 'package:quiz/utils/routes.dart';
import 'package:quiz/utils/ui_helpers.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final bloc = LoginBloc();

  @override
  void initState() {
    super.initState();
    listenFacebookLogin(bloc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Ingresa a tu cuenta')),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              OrientationBuilder(builder: (context, orientation) {
                return Container(
                    margin: EdgeInsets.all(10.0),
                    child: InkWell(
                        child: Image.asset(ImageConstants.facebookButtonImage),
                        onTap: () {
                          bloc.initiateFBLogin();
                        }));
              }),
            ]));
  }

  listenFacebookLogin(LoginBloc bloc) {
    bloc.facebookToken.listen((response) {
      Navigator.pushNamed(context, Routes.searchPlaces);
    }, onError: (error) {
      UiHelpers.showErrorDialog(context, error.toString());
    });
  }
}
