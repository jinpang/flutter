import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live/routers/application.dart';
import 'package:flutter_live/routers/routers.dart';

import 'common/constants/live_colors.dart';
import 'package:flutter_live/module/home/home.dart';
import 'module/home/welcome_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }

  MyApp() {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return new WelcomePage();
  }
}
