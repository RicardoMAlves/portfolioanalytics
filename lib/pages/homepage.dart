import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:portfolioanalytics/models/multilanguage.dart';
import 'dart:async';
import 'dart:convert';
import 'package:portfolioanalytics/widgets/customdrawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  MultiLanguage _multiLanguage = MultiLanguage();

  String _requestURL = "https://api.hgbrasil.com/finance?key=f2dc5200";

  var _decimalFormat = NumberFormat("#0.0000", "pt-br");

  Future<Map> _future;

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

  @override
  void initState() {
    super.initState();
    this._future = this._getFinanceIndicators();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            _multiLanguage.getLabelText("HomePage", "AppBar"),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "Arvo",
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20.0),
          ),
        ),
        drawer: CustomDrawer(_multiLanguage.getLabelText("HomePage", "DrawerHead"),
            0), // 0 = ItemDrawer Lista normal
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
                    future: _future,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.grey),
                            ),
                          );
                        default:
                          if ((snapshot.hasError) || (!snapshot.hasData))
                            return Center(
                              child:
                              Text(_multiLanguage.getLabelText(
                                  "HomePage", "CenterError")),
                            );
                      }
                      return Center(
                        child: Column(
                          children: [
                            _cardFinanceIndicators(
                                Icons.attach_money,
                                Colors.lightGreen,
                                snapshot.data["results"]["currencies"]
                                ["USD"]["buy"],
                                snapshot.data["results"]["currencies"]
                                ["USD"]["sell"],
                                snapshot.data["results"]["currencies"]
                                ["USD"]["variation"],
                                _multiLanguage.getLabelText("HomePage", "LabelBuy"),
                                _multiLanguage.getLabelText("HomePage", "LabelSell")),
                            _cardFinanceIndicators(
                                Icons.euro_symbol,
                                Colors.blueAccent,
                                snapshot.data["results"]["currencies"]
                                ["EUR"]["buy"],
                                snapshot.data["results"]["currencies"]
                                ["EUR"]["sell"],
                                snapshot.data["results"]["currencies"]
                                ["EUR"]["variation"],
                                _multiLanguage.getLabelText("HomePage", "LabelBuy"),
                                _multiLanguage.getLabelText("HomePage", "LabelSell")),
                          ],
                        ),
                      );
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

  Widget _cardFinanceIndicators(IconData iconData, Color currencyColor,
      double currencyBuy, double currencySell, double currencyVariation,
      String labelTextBuy, String labelTextSell) {
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
                SizedBox(
                  width: 6.0,
                ),
                Column(
                  children: [
                    Text(
                      labelTextBuy + " " + _decimalFormat.format(currencyBuy),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      labelTextSell + " " + _decimalFormat.format(currencySell),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  width: 170.0,
                ),
                Column(
                  children: [
                    Icon(
                      (currencyVariation > 0.0)
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                      color: (currencyVariation > 0.0)
                          ? Colors.lightGreen
                          : Colors.red,
                    ),
                    Text(
                      _decimalFormat.format(currencyVariation),
                      style: TextStyle(
                          color: (currencyVariation > 0.0)
                              ? Colors.lightGreen
                              : Colors.red,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold),
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

}
