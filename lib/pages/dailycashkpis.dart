import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:portfolioanalytics/utils/utildate.dart';
import 'package:portfolioanalytics/models/accountowner.dart';
import 'package:portfolioanalytics/widgets/buildchartdailycash.dart';
import 'package:portfolioanalytics/widgets/buildforecast.dart';
import 'package:portfolioanalytics/widgets/buildprofitability.dart';

class DailyCashKpis extends StatefulWidget {
  @override
  _DailyCashKpisState createState() => _DailyCashKpisState();
}

class _DailyCashKpisState extends State<DailyCashKpis> {
  AccountOwner accountOwner;

  DateTime _dateTime = DateTime.now();
  DateTime _startDate = DateTime.now().subtract(Duration(days: DateTime.now().day-1));
  DateTime _endDate = DateTime.now();

  int _firstMonthDay = 1;

  String _portfolioSelected = "All FIDCs";
  // ignore: unused_field
  String _text;

  List<DateTime> _picked = new List<DateTime>();

  UtilDate _utilDate = new UtilDate();

  void _setDateRangeSelected() {
    setState(() {
      if (_picked != null && _picked.length == 2) {
        _firstMonthDay = _picked[0].day;
        _dateTime = _picked[1];
        _startDate = _picked[0];
        _endDate = _picked[1];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () { Navigator.of(context).pop(); },
        ),
        title: Text(
          "Daily Cash Analysis",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Arvo",
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20.0),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Divider(),
              _buildDateRangeAnalysed(context),
              Divider(),
              BuildProfitability(_startDate, _endDate, _portfolioSelected),
              Divider(),
              BuildChartDailyCash(_startDate, _endDate, _portfolioSelected),
              Divider(),
              BuildForecast(),
            ],
          ),
        ),
      ),
      endDrawer: _buildPortfolioDrawer(),
    );
  }

  Widget _buildDateRangeAnalysed(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Card(
            color: Colors.grey[100],
            child: Container(
              width: 600.0,
              height: 70.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.date_range,
                          size: 40.0,
                          color: Colors.orangeAccent,
                        ),
                        onPressed: () async {
                          _picked = await DateRangePicker.showDatePicker(
                              context: context,
                              initialFirstDate: new DateTime.now(),
                              initialLastDate: (new DateTime.now())
                                  .add(new Duration(days: 7)),
                              firstDate: new DateTime(2019),
                              lastDate: new DateTime(2022));
                          _setDateRangeSelected();
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          SafeArea(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "$_portfolioSelected,\nCollections results from ${_firstMonthDay.toString()} to ${_dateTime.day.toString()}/${_utilDate.monthReduceExtension(_dateTime.month - 1)}",
                                    style: TextStyle(
                                        fontFamily: "Arvo",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey,
                                        fontSize: 15.0),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDrawerBack() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color.fromARGB(255, 203, 236, 241), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
    );
  }

  Widget _buildPortfolioDrawer() {
    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text(
                        "FIDCs &\nPortfolios",
                        style: TextStyle(
                            fontSize: 27.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                        left: 0.0,
                        bottom: 0.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Please select one of them >",
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
              Divider(),
              FutureBuilder<QuerySnapshot>(
                future: Firestore.instance
                    .collection("AccountOwner")
                    .getDocuments(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                      ),
                    );
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      accountOwner = AccountOwner.fromDocument(
                          snapshot.data.documents[index]);
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              Navigator.of(context).pop();
                              accountOwner = AccountOwner.fromDocument(
                                  snapshot.data.documents[index]);
                              _portfolioSelected =
                                  (accountOwner.portfolioAlias == "")
                                      ? accountOwner.accountOwnerAlias
                                      : accountOwner.portfolioAlias;
                            });
                          },
                          child: Container(
                            height: 60.0,
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.arrow_right,
                                  size: 32.0,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 32.0,
                                ),
                                Text(
                                  _text = (accountOwner.portfolioAlias == "")
                                      ? accountOwner.accountOwnerAlias
                                      : accountOwner.portfolioAlias,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
