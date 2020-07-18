import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CRUDDailyCash extends StatelessWidget {

  final databaseReference = Firestore.instance;
  
  int _refDate = 202006;
  DateTime _startDate;
  DateTime _endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FireStore CRUD Demo'),
      ),
      body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RaisedButton(
                child: Text('Create Record'),
                onPressed: () {
                  createRecord();
                },
              ),
              RaisedButton(
                child: Text('View Record'),
                onPressed: () {
                  getData();
                },
              ),
              RaisedButton(
                child: Text('Update Record'),
                onPressed: () {
                  updateData();
                },
              ),
              RaisedButton(
                child: Text('Delete Record'),
                onPressed: () {
                  deleteData();
                },
              ),
            ],
          )), //center
    );
  }

  void createRecord() async {
    await databaseReference.collection("DailyCash")
        .add({
      'AccountOwnerAlias': 'FIDCSobAvaliacao',
      'AgencyAlias': 'CobraBemPontoCom',
      'ChannelType': 'Digital',
      'CollectionAmount': 400.0,
      'CollectionForecast': 0.0,
      'DailyCashDate': DateTime(2020, 5, 1, 0, 0, 0, 0, 0),
      'ExtraAmount': 0.0,
      'Goal': 350.25,
      'PortfolioAlias': 'TVCaboFull',
      'RefDate': 202005,
    });

    await databaseReference.collection("DailyCash")
        .add({
      'AccountOwnerAlias': 'FIDCValeuApena',
      'AgencyAlias': 'Faz Dinheiro Ponto Com',
      'ChannelType': 'Digital',
      'CollectionAmount': 227.0,
      'CollectionForecast': 0.0,
      'DailyCashDate': DateTime(2020, 5, 4, 0, 0, 0, 0, 0),
      'ExtraAmount': 0.0,
      'Goal': 230.0,
      'PortfolioAlias': 'CelularAll',
      'RefDate': 202005,
    });

    await databaseReference.collection("DailyCash")
        .add({
      'AccountOwnerAlias': 'FIDCValeuApena',
      'AgencyAlias': 'Dim Dim Dim',
      'ChannelType': 'Escob',
      'CollectionAmount': 4300.0,
      'CollectionForecast': 0.0,
      'DailyCashDate': DateTime(2020, 5, 1, 0, 0, 0, 0, 0),
      'ExtraAmount': 0.0,
      'Goal': 5000.0,
      'PortfolioAlias': 'CasaEletro',
      'RefDate': 202005,
    });

    await databaseReference.collection("DailyCash")
        .add({
      'AccountOwnerAlias': 'FIDCSobAvaliacao',
      'AgencyAlias': 'Dim Dim Dim',
      'ChannelType': 'Escob',
      'CollectionAmount': 750.65,
      'CollectionForecast': 0.0,
      'DailyCashDate': DateTime(2020, 5, 4, 0, 0, 0, 0, 0),
      'ExtraAmount': 0.0,
      'Goal': 500.0,
      'PortfolioAlias': 'BancoIndia2',
      'RefDate': 202005,
    });

    await databaseReference.collection("DailyCash")
        .add({
      'AccountOwnerAlias': 'FIDCValeuApena',
      'AgencyAlias': 'Sabe Cobrar',
      'ChannelType': 'Escob',
      'CollectionAmount': 5600.0,
      'CollectionForecast': 0.0,
      'DailyCashDate': DateTime(2020, 5, 5, 0, 0, 0, 0, 0),
      'ExtraAmount': 0.0,
      'Goal': 3400.0,
      'PortfolioAlias': 'CasaEletro',
      'RefDate': 202005,
    });

    await databaseReference.collection("DailyCash")
        .add({
      'AccountOwnerAlias': 'FIDCSobAvaliacao',
      'AgencyAlias': 'Ponto Com QQ',
      'ChannelType': 'Digital',
      'CollectionAmount': 200.0,
      'CollectionForecast': 0.0,
      'DailyCashDate': DateTime(2020, 6, 1, 0, 0, 0, 0, 0),
      'ExtraAmount': 0.0,
      'Goal': 700.0,
      'PortfolioAlias': 'TVCaboFull',
      'RefDate': 202006,
    });

    await databaseReference.collection("DailyCash")
        .add({
      'AccountOwnerAlias': 'FIDCValeuApena',
      'AgencyAlias': 'Sabe Cobrar',
      'ChannelType': 'Escob',
      'CollectionAmount': 7000.0,
      'CollectionForecast': 0.0,
      'DailyCashDate': DateTime(2020, 6, 1, 0, 0, 0, 0, 0),
      'ExtraAmount': 0.0,
      'Goal': 3000.0,
      'PortfolioAlias': 'CasaEletro',
      'RefDate': 202006,
    });

    await databaseReference.collection("DailyCash")
        .add({
      'AccountOwnerAlias': 'FIDCSobAvaliacao',
      'AgencyAlias': 'Faz Dinheiro Ponto Com',
      'ChannelType': 'Digital',
      'CollectionAmount': 850.0,
      'CollectionForecast': 0.0,
      'DailyCashDate': DateTime(2020, 6, 1, 0, 0, 0, 0, 0),
      'ExtraAmount': 0.0,
      'Goal': 540.0,
      'PortfolioAlias': 'TVCaboFull',
      'RefDate': 202006,
    });

    await databaseReference.collection("DailyCash")
        .add({
      'AccountOwnerAlias': 'FIDCSobAvaliacao',
      'AgencyAlias': 'Sabe Cobrar',
      'ChannelType': 'Escob',
      'CollectionAmount': 560.0,
      'CollectionForecast': 0.0,
      'DailyCashDate': DateTime(2020, 6, 3, 0, 0, 0, 0, 0),
      'ExtraAmount': 0.0,
      'Goal': 700.0,
      'PortfolioAlias': 'BancoIndia2',
      'RefDate': 202006,
    });

    await databaseReference.collection("DailyCash")
        .add({
      'AccountOwnerAlias': 'FIDCValeuApena',
      'AgencyAlias': 'Ponto Com QQ',
      'ChannelType': 'Digital',
      'CollectionAmount': 3400.0,
      'CollectionForecast': 0.0,
      'DailyCashDate': DateTime(2020, 6, 2, 0, 0, 0, 0, 0),
      'ExtraAmount': 0.0,
      'Goal': 1000.0,
      'PortfolioAlias': 'CasaEletro',
      'RefDate': 202006,
    });

    await databaseReference.collection("DailyCash")
        .add({
      'AccountOwnerAlias': 'FIDCValeuApena',
      'AgencyAlias': 'Ponto Com QQ',
      'ChannelType': 'Digital',
      'CollectionAmount': 1200.0,
      'CollectionForecast': 0.0,
      'DailyCashDate': DateTime(2020, 6, 2, 0, 0, 0, 0, 0),
      'ExtraAmount': 0.0,
      'Goal': 870.0,
      'PortfolioAlias': 'CelularAll',
      'RefDate': 202006,
    });

    await databaseReference.collection("DailyCash")
        .add({
      'AccountOwnerAlias': 'FIDCSobAvaliacao',
      'AgencyAlias': 'Ponto Com QQ',
      'ChannelType': 'Digital',
      'CollectionAmount': 1500.45,
      'CollectionForecast': 0.0,
      'DailyCashDate': DateTime(2020, 7, 1, 0, 0, 0, 0, 0),
      'ExtraAmount': 0.0,
      'Goal': 2700.0,
      'PortfolioAlias': 'TVCaboFull',
      'RefDate': 202006,
    });

    await databaseReference.collection("DailyCash")
        .add({
      'AccountOwnerAlias': 'FIDCSobAvaliacao',
      'AgencyAlias': 'Ponto Com QQ',
      'ChannelType': 'Digital',
      'CollectionAmount': 3456.75,
      'CollectionForecast': 0.0,
      'DailyCashDate': DateTime(2020, 7, 2, 0, 0, 0, 0, 0),
      'ExtraAmount': 0.0,
      'Goal': 2900.0,
      'PortfolioAlias': 'TVCaboFull',
      'RefDate': 202006,
    });

    /*DocumentReference ref = await databaseReference.collection("books")
        .add({
      'title': 'Flutter in Action',
      'description': 'Complete Programming Guide to learn Flutter'
    });*/

  }

  void getData() {

    _startDate = DateTime.now().subtract(Duration(days: DateTime.now().day-1));
    _endDate = DateTime.now();

    print(_startDate);
    print(_endDate);

    databaseReference
        .collection("DailyCash")
        .document(_refDate.toString())
        .collection("DailyCashByDay")
        .where("DailyCashDate", isGreaterThanOrEqualTo: _startDate, isLessThanOrEqualTo: _endDate)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
          snapshot.documents.forEach((element) {print(element.data);});
    });
  }

  void updateData() {
    try {
      databaseReference
          .collection('acessosmes')
          .document('jun2020')
          .updateData({'SemDividas': 0});
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteData() {
    try {
      databaseReference
          .collection('acessosmes')
          .document('jun2020')
          .delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
