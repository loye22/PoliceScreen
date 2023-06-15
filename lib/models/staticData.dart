class MyData {
  static String _data = '';
  static List<String> _myList = [];




  static List<String> get myList => _myList;

  static set myList(List<String> newList) {
    _myList = newList;

  }









  static set data(String value) {
    _data = value;
  }

  static String get data {
    return _data;
  }
}
