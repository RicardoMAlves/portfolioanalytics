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
    await databaseReference.collection("acessosmes")
        .document("jun2020")
        .setData({
      'ComDividas': 350,
      'DataFim': 30/06/2020,
      'DataInicio': 01/06/2020,
      'RefDate': '202006',
      'SemDividas': 2000,
      'UsuariosCadastrados': 2350
    });

    /*DocumentReference ref = await databaseReference.collection("books")
        .add({
      'title': 'Flutter in Action',
      'description': 'Complete Programming Guide to learn Flutter'
    });*/

    print(databaseReference.collection("acessosmes").document("jun2020"));
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
