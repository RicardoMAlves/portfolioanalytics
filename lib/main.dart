import 'package:flutter/material.dart';
import 'package:portfolioanalytics/pages/dailycashkpis.dart';
import 'package:portfolioanalytics/pages/homepage.dart';
import 'package:portfolioanalytics/pages/lifetimekpis.dart';
import 'package:portfolioanalytics/pages/login.dart';
import 'package:portfolioanalytics/pages/signup.dart';
import 'package:portfolioanalytics/testdb/cruddailycash.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {

  Map<int, Color> color = {
    50:Color.fromRGBO(136,14,79, .1),
    100:Color.fromRGBO(136,14,79, .2),
    200:Color.fromRGBO(136,14,79, .3),
    300:Color.fromRGBO(136,14,79, .4),
    400:Color.fromRGBO(136,14,79, .5),
    500:Color.fromRGBO(136,14,79, .6),
    600:Color.fromRGBO(136,14,79, .7),
    700:Color.fromRGBO(136,14,79, .8),
    800:Color.fromRGBO(136,14,79, .9),
    900:Color.fromRGBO(136,14,79, 1),
  };

  @override
  Widget build(BuildContext context) {

    MaterialColor colorCustom = MaterialColor(0xff01A0C7, color);

    return MaterialApp(
      title: 'Portfolio Analytics - Demo',
      theme: ThemeData(
        primarySwatch: colorCustom,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/login",
      routes: <String, WidgetBuilder>{
        "/login": (BuildContext context) => Login(),
        "/signup": (BuildContext context) => SignUp(),
        "/homepage": (BuildContext context) => HomePage(),
        "/dailyCashKpis": (BuildContext context) => DailyCashKpis(),
        "/lifetimeKpis": (BuildContext context) => LifeTimeKpis(),
        "/crudTest": (BuildContext context) => CRUDDailyCash(),
      },
    );
  }
}
