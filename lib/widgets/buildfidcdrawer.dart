import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:portfolioanalytics/models/accountowner.dart';

// ignore: must_be_immutable
class BuildFIDCDrawer extends StatelessWidget {

  AccountOwner accountOwner;

  @override
  Widget build(BuildContext context) {

    final _backGroundColor = Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color.fromARGB(255, 203, 236, 241), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
    );

    final _headerText = Container(
      margin: EdgeInsets.only(bottom: 8.0),
      padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
      height: 170.0,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 8.0,
            left: 0.0,
            child: Text(
              "Fundos de Investimentos\nem Direitos Creditórios\n(FIDC)",
              style: TextStyle(
                  fontSize: 20.0, fontWeight: FontWeight.bold),
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
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ))
        ],
      ),
    );

    Stream<QuerySnapshot> fetchFIDCs() {
      return Firestore.instance
          .collection("AccountOwner")
          .where("PortfolioAlias", isEqualTo: "")
          .snapshots();
    }
    
    return Drawer(
      child: Stack(
        children: [
          _backGroundColor,
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: [
              _headerText,
              Divider(),
              StreamBuilder<QuerySnapshot>(
                stream: fetchFIDCs(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) return Text("Ops! Error ${snapshot.error}");
                  if (!snapshot.hasData) return Text("Ops! No FIDC found.");
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
                          onTap: () {},
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
                                  accountOwner.accountOwnerAlias,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  );
                }
              ),
            ],
          ),
        ],
      ),
    );

  }
}
