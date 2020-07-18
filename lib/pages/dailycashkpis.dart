import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:portfolioanalytics/models/dailycash.dart';
import 'package:portfolioanalytics/models/accountowner.dart';
import 'package:portfolioanalytics/models/daysofmonth.dart';
import 'package:portfolioanalytics/utils/utildate.dart';

class DailyCashKpis extends StatefulWidget {
  @override
  _DailyCashKpisState createState() => _DailyCashKpisState();
}

class _DailyCashKpisState extends State<DailyCashKpis> {
  AccountOwner accountOwner;
  DailyCash dailyCash;

  UtilDate _utilDate = new UtilDate();

  DateTime _dateTime = DateTime.now();
  DateTime _startDate =
      DateTime.now().subtract(Duration(days: DateTime.now().day - 1));
  DateTime _endDate = DateTime.now();

  // ignore: unused_field
  String _text;
  String _portfolioSelected = "All FIDCs";
  String _monthSelected;

  int _firstMonthDay = 1;
  int _businessUnitType = 0;

  double _percent = 0.0;
  double _cash;
  double _goal;


  List<DateTime> _picked = new List<DateTime>();

  final List<DaysOfMonth> _listDaysOfMonth = [];

  var _decimalFormat = NumberFormat("###,##0.00", "pt-br");
  var _percentFormat = NumberFormat("#,##0.00", "pt-br");

  Stream<QuerySnapshot> _streamDailyCash;

  void _setDateRangeSelected() {
    setState(() {
      if (_picked != null && _picked.length == 2) {
        _firstMonthDay = _picked[0].day;
        _dateTime = _picked[1];
        _startDate = _picked[0];
        _endDate = _picked[1];
        _listDaysOfMonth.clear();
        this._streamDailyCash = this._fetchDailyCash();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this._streamDailyCash = this._fetchDailyCash();
  }

  @override
  Widget build(BuildContext context) {

    _monthSelected = _utilDate.monthReduceExtension(this._endDate.month-1);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
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
              _buildProfitability(),
              Divider(),
              _buildChartDailyCash(),
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
                                    "$_portfolioSelected,\nCollections from ${_firstMonthDay.toString()}/${_utilDate.monthReduceExtension(_startDate.month - 1)} to ${_dateTime.day.toString()}/${_utilDate.monthReduceExtension(_dateTime.month - 1)}",
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
                              _businessUnitType = accountOwner.businessUnitType;
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

  Widget _buildProfitability() {

    return StreamBuilder<QuerySnapshot>(
      stream: _streamDailyCash,
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text("Ops! Error ${snapshot.error}");
        if (!snapshot.hasData) return Text("Ops! No daily cash found.");
        _cash = 0.0;
        _goal = 0.0;
        snapshot.data.documents.forEach((element) {
          dailyCash = DailyCash.fromDocument(element);
          _cash += dailyCash.collectionAmount;
          _goal += dailyCash.goal;
          _listDaysOfMonth.add(DaysOfMonth(
              dayOfMonth: dailyCash.dailyCashDate.day.toString(),
              amountResult: dailyCash.collectionAmount.round(),
              barColor: charts.ColorUtil.fromDartColor(Colors.blue)));
        });
        if (_cash != 0.0 || _goal != 0.0) _percent = ((_cash / _goal) * 100);
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

  Widget _buildChartDailyCash() {

    final List<charts.Series<DaysOfMonth, String>> series = [
      new charts.Series(
        id: "Daily Cash",
        colorFn: (DaysOfMonth series, _) => series.barColor,
        domainFn: (DaysOfMonth series, _) => series.dayOfMonth.toString(),
        measureFn: (DaysOfMonth series, _) => series.amountResult,
        data: _listDaysOfMonth,)
    ];

    return Container(
      //width: 600.0,
      height: 400.0,
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
                child: new charts.BarChart(series, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }

  Stream<QuerySnapshot> _fetchDailyCash() {

    DateTime _startDate = _utilDate.changeTime(this._startDate, 0, 0, 0, 0);
    DateTime _endDate = _utilDate.changeTime(this._endDate, 0, 0, 0, 0);

    if (this._portfolioSelected == "All FIDCs")
      return Firestore.instance
          .collection("DailyCash")
          .where("DailyCashDate",
              isGreaterThanOrEqualTo: _startDate, isLessThanOrEqualTo: _endDate)
          .snapshots();

    if (this._businessUnitType == 1) // 1 = Fundos e 2 = Portfolios
      return Firestore.instance
          .collection("DailyCash")
          .where("DailyCashDate",
              isGreaterThanOrEqualTo: _startDate, isLessThanOrEqualTo: _endDate)
          .where("AccountOwnerAlias", isEqualTo: this._portfolioSelected)
          .snapshots();

    return Firestore.instance
        .collection("DailyCash")
        .where("DailyCashDate",
            isGreaterThanOrEqualTo: _startDate, isLessThanOrEqualTo: _endDate)
        .where("PortfolioAlias", isEqualTo: this._portfolioSelected)
        .snapshots();
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
}
