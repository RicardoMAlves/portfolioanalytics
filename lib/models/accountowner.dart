import 'package:cloud_firestore/cloud_firestore.dart';

class AccountOwner {

  String documentID;
  String accountOwnerAlias;
  int accountOwnerID;
  String portfolioAlias;
  int portfolioID;

  AccountOwner.fromDocument(DocumentSnapshot snapshot) {
    documentID = snapshot.documentID;
    accountOwnerAlias = snapshot.data["AccountOwnerAlias"];
    accountOwnerID = snapshot.data["AccountOwnerID"];
    portfolioAlias = snapshot.data["PortfolioAlias"];
    portfolioID = snapshot.data["PortfolioID"];
  }

}