import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:portfolioanalytics/widgets/customdrawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String _requestURL = "https://api.hgbrasil.com/finance?key=73b7fadd";

  var _decimalFormat = NumberFormat("#0.0000", "pt-br");

  static final _containerLogo = Container(
    width: 600.0,
    height: 200.0,
    margin: EdgeInsets.all(5.0),
    decoration: BoxDecoration(
      color: Colors.transparent,
    ),
    child: Align(
      alignment: Alignment.topCenter,
      child: Image.asset(
        "images/logo_viability3.png",
        fit: BoxFit.contain,
      ),
    ),
  );

  Future<Map> _getFinanceIndicators() async {
    http.Response response = await http.get(_requestURL);
    return json.decode(response.body);
  }

  Widget _cardFinanceIndicators(IconData iconData, Color currencyColor, double currencyBuy, double currencySell, double currencyVariation) {
    return Card(
      color: Colors.white,
      child: Container(
        width: 600.0,
        height: 50.0,
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
                Icon(
                  iconData,
                  color: currencyColor,
                ),
                SizedBox(width: 6.0,),
                Column(
                  children: [
                    Text(
                      "Buy " + _decimalFormat.format(currencyBuy),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      "Sell " + _decimalFormat.format(currencySell),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 170.0,),
                Column(
                  children: [
                    Icon(
                      (currencyVariation > 0.0) ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      color: (currencyVariation > 0.0) ? Colors.lightGreen : Colors.red,
                    ),
                    Text(
                      _decimalFormat.format(currencyVariation),
                      style: TextStyle(
                          color: (currencyVariation > 0.0) ? Colors.lightGreen : Colors.red,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "News",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "Arvo",
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20.0),
          ),
        ),
        drawer: CustomDrawer("Portfolio Analytics\nGross & Expenses\nAnalysis", 0), // 0 = ItemDrawer Lista normal
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _containerLogo,
                Container(
                  width: 600.0,
                  height: 355.0,
                  margin: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: FutureBuilder(
                    future: _getFinanceIndicators(),
                    builder: (context, snapshot) {
                      switch(snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                            ),
                          );
                        default:
                          if (snapshot.hasError)
                            return Center(child: Text("Ops!! Web site HG Brazil has error."),);
                          else
                            return Center(
                              child: Column(
                                children: [
                                  _cardFinanceIndicators(Icons.attach_money,
                                    Colors.lightGreen,
                                    snapshot.data["results"]["currencies"]["USD"]["buy"],
                                    snapshot.data["results"]["currencies"]["USD"]["sell"],
                                    snapshot.data["results"]["currencies"]["USD"]["variation"]),
                                  _cardFinanceIndicators(Icons.euro_symbol,
                                      Colors.blueAccent,
                                      snapshot.data["results"]["currencies"]["EUR"]["buy"],
                                      snapshot.data["results"]["currencies"]["EUR"]["sell"],
                                      snapshot.data["results"]["currencies"]["EUR"]["variation"]),
                                ],
                              ),
                            );
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
