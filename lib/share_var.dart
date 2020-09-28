import 'package:shared_preferences/shared_preferences.dart';

class shareVar {
  Future<void> getshared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  Future<String> getStr(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var hasil = prefs.getString(key);
    return hasil;
  }

  Future<void> setStr(key, _value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var hasil = prefs.setString(key, _value);
    return hasil;
  }

  Future<List<String>> getList(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var hasil = prefs.getStringList(key);
    return hasil;
  }

  Future<void> setList(key, _value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var hasil = prefs.setStringList(key, _value);
    return hasil;
  }

  Future<void> clearall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> clear(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
