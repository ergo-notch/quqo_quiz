import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz/ui/screens/login_screen.dart';
import 'package:quiz/utils/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _Main createState() => _Main();
}

class _Main extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);

    return MaterialApp(
      title: 'Test',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: new ThemeData(
          primarySwatch: Colors.red,
          primaryTextTheme: TextTheme(title: TextStyle(color: Colors.white))),
      home: LoginScreen(),
      routes: Navigation.routes,
    );
  }
}
