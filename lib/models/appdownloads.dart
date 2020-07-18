import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AppDownloads {
  final String year;

  final double count;

  final charts.Color barColor;

  AppDownloads({
    @required this.year,
    @required this.count,
    @required this.barColor,
  });
}
