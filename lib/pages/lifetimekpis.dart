import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portfolioanalytics/widgets/buildfidcdrawer.dart';

class LifeTimeKpis extends StatefulWidget {
  @override
  _LifeTimeKpisState createState() => _LifeTimeKpisState();
}

class _LifeTimeKpisState extends State<LifeTimeKpis> {

  var _decimalFormat = NumberFormat("###,###,##0.00", "pt-br");

  static final _textOriginalFaceValue = Positioned(
    bottom: 80.0,
    right: 10.0,
    child: Text(
      "15.000.000,00",
      style: TextStyle(
          fontSize: 15.0,
          color: Colors.white
      ),
    ),
  );

  static final _textOriginalFaceText = Positioned(
    bottom: 80.0,
    left: 10.0,
    child: Text(
      "Original Face Value",
      style: TextStyle(
          fontSize: 15.0,
          color: Colors.white
      ),
    ),
  );

  static final _textFIDCName = Positioned(
    bottom: 120.0,
    left: 10.0,
    child: Text(
      "FIDC xxxxx",
      style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.white
      ),
    ),
  );

  static final _iconeCompanyColumn = Column(
    children: [
      Icon(
        Icons.account_balance,
        color: Colors.orangeAccent,
        size: 25.0,
      ),
    ],
  );

  static final _iconeGrossColumn = Column(
    children: [
      Icon(
        Icons.attach_money,
        color: Colors.lightGreen,
        size: 25.0,
      ),
    ],
  );

  static final _rowPortfolioName = Row(
    children: [
      Text(
        "Portfolio teste",
        style: TextStyle(
          color: Colors.black,
          fontSize: 13.0,
          fontWeight: FontWeight.bold
        ),
      )
    ],
  );

  static final _rowCurrentFaceValue = Row(
    children: [
      Text(
        "2,000,000.00",
        style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 12.0,
            fontWeight: FontWeight.bold
        ),
      )
    ],
  );

  static final _rowDebtsQuantity = Row(
    children: [
      Text(
        "12.543",
        style: TextStyle(
            color: Colors.red,
            fontSize: 13.0,
            fontWeight: FontWeight.bold
        ),
      )
    ],
  );

  static final _rowTextDebts = Row(
    children: [
      Text(
        "Debts",
        style: TextStyle(
            color: Colors.redAccent,
            fontSize: 12.0,
            fontWeight: FontWeight.bold
        ),
      )
    ],
  );

  static final _columnGrossLifeToDate = Row(
    children: [
      Text(
        "10,000.00 Gross",
        style: TextStyle(
            color: Colors.black,
            fontSize: 13.0,
            fontWeight: FontWeight.bold
        ),
      )
    ],
  );

  static final _columnGrossEfficiency = Row(
    children: [
      Text(
        "1.27% Efficiency",
        style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 12.0,
            fontWeight: FontWeight.bold
        ),
      )
    ],
  );

  static final _rowProfitabilityValue = Row(
    children: [
      Text(
        "1,000.00",
        style: TextStyle(
            color: Colors.lightGreen,
            fontSize: 13.0,
            fontWeight: FontWeight.bold
        ),
      )
    ],
  );

  static final _rowProfitabilityPercent = Row(
    children: [
      Text(
        "10.3%",
        style: TextStyle(
            color: Colors.lightGreen,
            fontSize: 12.0,
            fontWeight: FontWeight.bold
        ),
      )
    ],
  );

  Widget _cardPortfolios() {
    return Center(
      child: Column(
        children: [
          Card(
            color: Colors.grey[100],
            child: Container(
              width: 600.0,
              height: 80.0,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _iconeCompanyColumn,
                      SizedBox(width: 6.0,),
                      Column(
                        children: [
                          _rowPortfolioName,
                          _rowCurrentFaceValue,
                        ],
                      ),
                      SizedBox(width: 170.0,),
                      Column(
                        children: [
                          _rowDebtsQuantity,
                          _rowTextDebts,
                        ],
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey[100],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _iconeGrossColumn,
                      SizedBox(width: 6.0,),
                      Column(
                        children: [
                          _columnGrossLifeToDate,
                          _columnGrossEfficiency,
                        ],
                      ),
                      SizedBox(width: 110.0,),
                      Column(
                        children: [
                          _rowProfitabilityValue,
                          _rowProfitabilityPercent,
                        ],
                      ),
                      SizedBox(width: 3.0,),
                      Icon(
                        Icons.arrow_drop_up,
                        color: Colors.lightGreen,
                        size: 25.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listKpisLifeTime() {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 600.0,
              height: 200.0,
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  _textFIDCName,
                  _textOriginalFaceText,
                  _textOriginalFaceValue,
                ],
              ),
            ),
            Container(
              width: 600.0,
              height: 355.0,
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.white24,
                border: Border.all(
                  color: Colors.grey,
                  width: 2.0
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  _cardPortfolios(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () { Navigator.of(context).pop(); },
        ),
        title: Text(
          "Life Time Analysis",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Arvo",
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20.0),
        ),
      ),
      body: _listKpisLifeTime(),
      endDrawer: BuildFIDCDrawer(),
    );
  }
}
