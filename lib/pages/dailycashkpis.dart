import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:portfolioanalytics/utils/utildate.dart';

class DailyCashKpis extends StatefulWidget {
  @override
  _DailyCashKpisState createState() => _DailyCashKpisState();
}

class _DailyCashKpisState extends State<DailyCashKpis> {
  DateTime _dateTime = DateTime.now();
  int _firstMonthDay = 1;
  String dropdownValue = "Portfolios";

  List<DateTime> picked = new List<DateTime>();

  UtilDate _utilDate = new UtilDate();

  void _setDateRangeSelected() {
    setState(() {
      if (picked != null && picked.length == 2) {
        _firstMonthDay = picked[0].day;
        _dateTime = picked[1];
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
          onPressed: () {},
        ),
        title: Text(
          "Portfolio Analytics",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Arvo",
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20.0),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(),
            _buildDateRangeAnalysed(context),
          ],
        ),
      ),
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
              height: 100.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.date_range,
                          size: 50.0,
                        ),
                        onPressed: () async {
                          picked = await DateRangePicker.showDatePicker(
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
                      Row(
                        children: [
                          Text(
                            "Período: ${_firstMonthDay.toString()} à ${_dateTime.day.toString()}/${_utilDate.monthReduceExtension(_dateTime.month - 1)}",
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
                          DropdownButton<String>(
                            value: dropdownValue,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 12,
                            elevation: 16,
                            style: TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue = newValue;
                              });
                            },
                            items: <String>['Portfolios', 'Two', 'Free', 'Four']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )
                        ],
                      )
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
}
