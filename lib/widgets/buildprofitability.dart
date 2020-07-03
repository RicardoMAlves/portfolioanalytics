import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portfolioanalytics/utils/utildate.dart';

class BuildProfitability extends StatefulWidget {
  final DateTime _startDate;
  final DateTime _endDate;
  final String _portfolio;

  @override
  _BuildProfitabilityState createState() => _BuildProfitabilityState();

  BuildProfitability(this._startDate, this._endDate, this._portfolio);
}

class _BuildProfitabilityState extends State<BuildProfitability> {
  UtilDate _utilDate = new UtilDate();

  int _refDate;
  double _cash;
  double _goal;
  double _percent = 0.0;

  var _decimalFormat = NumberFormat("###,##0.00", "pt-br");
  var _percentFormat = NumberFormat("#,##0.00", "pt-br");

  @override
  Widget build(BuildContext context) {
    _refDate = _utilDate.convertDateTimeToRefDate(widget._endDate);
    _cash = 0.0;
    _goal = 0.0;

    return StreamBuilder<QuerySnapshot>(
      stream: fetchDailyCash(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text("Ops! Error ${snapshot.error}");
        if (!snapshot.hasData) return Text("Ops! No daily cash found.");
        snapshot.data.documents.forEach((element) {
          print(
              "${element.data["DailyCashDate"]} ${element.data["CollectionAmount"]}");
          _cash += element.data["CollectionAmount"];
          _goal += element.data["Goal"];
        });
        if (_cash != 0.0 || _goal != 0.0)
          _percent = ((_cash / _goal) * 100);
        return Center(
          child: Column(
            children: [
              Card(
                color: Colors.grey[100],
                child: Container(
                  width: 600.0,
                  height: 70.0,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.attach_money,
                              size: 35.0,
                              color: Colors.green,
                            ),
                            Text(
                              _decimalFormat.format(_cash),
                              style: TextStyle(
                                  fontFamily: "Arvo",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey,
                                  fontSize: 15.0),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.adjust,
                              size: 35.0,
                              color: Colors.redAccent,
                            ),
                            Text(
                              _decimalFormat.format(_goal),
                              style: TextStyle(
                                  fontFamily: "Arvo",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey,
                                  fontSize: 15.0),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _returnIcon(),
                            Text(
                              _percentFormat.format(_percent) + "%",
                              style: TextStyle(
                                  fontFamily: "Arvo",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey,
                                  fontSize: 15.0),
                            ),
                          ],
                        ),
                      ]),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _returnIcon() {
    if (_percent < 100.0)
      return Icon(
        Icons.call_received,
        size: 35.0,
        color: Colors.redAccent,
      );
    return Icon(
      Icons.call_made,
      size: 35.0,
      color: Colors.green,
    );
  }

  Stream<QuerySnapshot> fetchDailyCash() {
    DateTime _startDate = _utilDate.changeTime(widget._startDate, 0, 0, 0, 0);
    DateTime _endDate = _utilDate.changeTime(widget._endDate, 0, 0, 0, 0);

    print("Start date: $_startDate End date: $_endDate");
    print("Cash: $_cash Goal: $_goal");
    print(_refDate.toString());

    if (widget._portfolio == "All FIDCs")
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
        .where("PortfolioAlias", isEqualTo: widget._portfolio)
        .snapshots();
  }
}
