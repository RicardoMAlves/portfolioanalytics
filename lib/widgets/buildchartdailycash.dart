import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:portfolioanalytics/models/daysofmonth.dart';
import 'package:portfolioanalytics/utils/utildate.dart';

// ignore: must_be_immutable
class BuildChartDailyCash extends StatelessWidget {

  final DateTime _startDate;
  final DateTime _endDate;
  final String _portfolio;

  final List<DaysOfMonth> _listDaysOfMonth = [];

  UtilDate utilsDate = UtilDate();

  String _monthSelected;
  DateTime _dateConverted;
  Timestamp _timestamp;
  double _amountConverted;

  var _decimalFormat = NumberFormat("###.00", "en-us");

  BuildChartDailyCash(this._startDate, this._endDate, this._portfolio);

  @override
  Widget build(BuildContext context) {

    _monthSelected = utilsDate.monthReduceExtension(this._endDate.month-1);

    return StreamBuilder<QuerySnapshot>(
        stream: fetchDailyCash(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text("Ops! Error ${snapshot.error}");
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
              ),
            );
          snapshot.data.documents.forEach((element) {
            _timestamp = element.data["DailyCashDate"];
            _dateConverted = DateTime.fromMillisecondsSinceEpoch(_timestamp.millisecondsSinceEpoch);
            _amountConverted = double.parse(_decimalFormat.format(element.data["CollectionAmount"]));
            _listDaysOfMonth.add(DaysOfMonth(
                dayOfMonth: _dateConverted.day,
                amountResult: _amountConverted,
                barColor: charts.ColorUtil.fromDartColor(Colors.blue)));

          });
          List<charts.Series<DaysOfMonth, String>> series = [
            charts.Series(
                id: "Daily Cash",
                data: _listDaysOfMonth,
                domainFn: (DaysOfMonth series, _) => series.dayOfMonth.toString(),
                measureFn: (DaysOfMonth series, _) => series.amountResult,
                colorFn: (DaysOfMonth series, _) => series.barColor)
          ];
          return Container(
            width: 600.0,
            height: 280.0,
            padding: EdgeInsets.all(20),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "$_monthSelected",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontFamily: "Arvo",
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: charts.BarChart(series, animate: true),
                    )
                  ],
                ),
              ),
            ),
          );
        },
    );
  }

  Stream<QuerySnapshot> fetchDailyCash() {
    DateTime _startDate = utilsDate.changeTime(this._startDate, 0, 0, 0, 0);
    DateTime _endDate = utilsDate.changeTime(this._endDate, 0, 0, 0, 0);
    int _refDate = utilsDate.convertDateTimeToRefDate(this._endDate);

    if (this._portfolio == "All FIDCs")
      return Firestore.instance
          .collection("DailyCash")
          .document(_refDate.toString())
          .collection("DailyCashByDay")
          .where("DailyCashDate",
          isGreaterThanOrEqualTo: _startDate, isLessThanOrEqualTo: _endDate)
          .snapshots();

    return Firestore.instance
        .collection("DailyCash")
        .document(_refDate.toString())
        .collection("DailyCashByDay")
        .where("DailyCashDate",
        isGreaterThanOrEqualTo: _startDate, isLessThanOrEqualTo: _endDate)
        .where("PortfolioAlias", isEqualTo: this._portfolio)
        .snapshots();
  }

}
