import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DaysOfMonth {

  final int dayOfMonth;
  final double amountResult;
  final charts.Color barColor;


  DaysOfMonth({
    @required this.dayOfMonth,
    @required this.amountResult,
    @required this.barColor
  });

}