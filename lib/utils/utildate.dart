class UtilDate {

  List<String> _monthReduceExtension = [
    "Jan","Fev","Mar","Abr","Mai","Jun","Jul","Ago","Set","Out","Nov","Dez"
  ];

  List<String> _monthFullExtension = [
    "Janeiro","Fevereiro","Março","Abril","Maio","Junho","Julho","Agosto",
    "Setembro","Outubro","Novembro","Dezembro"
  ];

  List<String> _monthNumeric = [
    "01","02","03","04","05","06","07","08", "09","10","11","12"
  ];

  String monthReduceExtension(int _month) {
    return _monthReduceExtension[_month];
  }

  String monthFullExtension(int _month) {
    return _monthFullExtension[_month];
  }

  String refDateSystemDate() {
    return(DateTime.now().year.toString() + _monthNumeric[DateTime.now().month - 1]);
  }

  String monthNumeric(int _month) {
    return _monthNumeric[_month - 1];
  }

}