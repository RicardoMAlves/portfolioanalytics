import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portfolioanalytics/utils/utildate.dart';

class BuildProfitability extends StatefulWidget {

  final DateTime _startDate;
  final DateTime _endDate;

  @override
  _BuildProfitabilityState createState() => _BuildProfitabilityState();

  BuildProfitability(this._startDate, this._endDate);
}

class _BuildProfitabilityState extends State<BuildProfitability> {

  UtilDate _utilDate = new UtilDate();

  int _refDate;
  double _cash;
  double _goal;

  @override
  Widget build(BuildContext context) {

    _refDate = _utilDate.convertDateTimeToRefDate(widget._endDate);
    _cash = 0.0;
    _goal = 0.0;

    return StreamBuilder<QuerySnapshot>(
      stream: fetchDailyCash(),
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return Text("Ops! Error ${snapshot.error}");
        if (!snapshot.hasData)
          return Text("Ops! No daily cash found.");
        snapshot.data.documents.forEach((element) {
          print(element.data["CollectionAmount"]);
          _cash += element.data["CollectionAmount"];
          _goal += element.data["Goal"];
        });
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.attach_money,
                              size: 55.0,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("")
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Cash: $_cash",
                                  style: TextStyle(
                                      fontFamily: "Arvo",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey,
                                      fontSize: 20.0),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Goal: $_goal",
                                  style: TextStyle(
                                      fontFamily: "Arvo",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey,
                                      fontSize: 20.0),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.call_made,
                              size: 25.0,
                            ),
                          ],
                        ),
                      ]
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Stream<QuerySnapshot> fetchDailyCash() {

    DateTime _startDate = _utilDate.changeTime(widget._startDate, 0, 0, 0, 0);
    DateTime _endDate = _utilDate.changeTime(widget._endDate, 0, 0, 0, 0);

    return Firestore.instance
        .collection("DailyCash")
        .document(_refDate.toString())
        .collection("DailyCashByDay")
        .where("DailyCashDate", isGreaterThanOrEqualTo: _startDate, isLessThanOrEqualTo: _endDate)
        .snapshots();
  }

}
