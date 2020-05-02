import 'package:flutter/material.dart';
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
    return MaterialApp(
      title: 'Test',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: LoginScreen(),
      routes: Navigation.routes,
    );
  }
}

