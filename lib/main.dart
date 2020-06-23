import 'package:flutter/material.dart';
import 'package:portfolioanalytics/pages/dailycashkpis.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio Analytics - Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    initialRoute: "/dailyCashKpis",
    routes: <String, WidgetBuilder>{
      "/dailyCashKpis": (BuildContext context) => DailyCashKpis(),
    },
    );
  }
}
