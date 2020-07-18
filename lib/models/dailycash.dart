import 'package:cloud_firestore/cloud_firestore.dart';

class DailyCash {

  String documentID;
  String accountOwnerAlias;
  String agencyAlias;
  String channelType;
  double collectionAmount;
  double collectionForecast;
  DateTime dailyCashDate;
  double extraAmount;
  double goal;
  String portfolioAlias;
  int refDate;

  DailyCash.fromDocument(DocumentSnapshot snapshot) {
    documentID = snapshot.documentID;
    accountOwnerAlias = snapshot.data["AccountOwnerAlias"];
    agencyAlias = snapshot.data["AgencyAlias"];
    channelType = snapshot.data["ChannelType"];
    collectionAmount = double.parse(snapshot.data["CollectionAmount"].toString());
    collectionForecast = double.parse(snapshot.data["CollectionForecast"].toString());
    dailyCashDate = snapshot.data["DailyCashDate"].toDate();
    extraAmount = double.parse(snapshot.data["ExtraAmount"].toString());
    goal = double.parse(snapshot.data["Goal"].toString());
    portfolioAlias = snapshot.data["PortfolioAlias"];
    refDate = snapshot.data["RefDate"];
  }

}