class UtilDate {

  List<String> _monthReduceExtension = [
    "Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"
  ];

  List<String> _monthFullExtension = [
    "January","February","March","April","May","June","July","August",
    "September","October","November","December"
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

  int convertDateTimeToRefDate(DateTime _date) {
    String _month;
    switch(_date.month) {
      case 1: _month = "01"; break;
      case 2: _month = "02"; break;
      case 3: _month = "03"; break;
      case 4: _month = "04"; break;
      case 5: _month = "05"; break;
      case 6: _month = "06"; break;
      case 7: _month = "07"; break;
      case 8: _month = "08"; break;
      case 9: _month = "09"; break;
      default: _month = _date.month.toString();
    }
    return int.parse(_date.year.toString() + _month);
  }

  DateTime changeTime(DateTime dateTime, int hours, int minutes, int seconds, int milliseconds) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day, hours, minutes, seconds, milliseconds);
  }

}