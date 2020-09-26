import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home/constants.dart';
import 'package:smart_home/models/arduino.dart';
import 'package:smart_home/models/detail_header.dart';
import 'package:smart_home/share_var.dart';

class RestNode {
  //static const String url = 'http://192.168.209.80:3000/';

  // static const String url = 'http://192.168.100.100:3003/';

  static Future<List<Arduino>> getArduino() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = 'http://' + prefs.getString('ip');

    try {
      final response = await http.get(url + ':3003/arduino_list');

      if (response.statusCode == 200) {
        final result = arduinoFromJson(response.body);

        return result;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      // throw Exception(e.toList());
    }
  }

  static Future<List<DetailHeader>> getDetailHeader(String tipe) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = 'http://' + prefs.getString('ip');

    try {
      final response = await http.get(url + ':3003/show_detail/' + tipe);

      if (response.statusCode == 200) {
        final result = detailHeaderFromJson(response.body);

        return result;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      // throw Exception(e.toList());
    }
  }

  // static Future<User> findUser(String user, String pass) async {
  //   try {
  //     final response = await http.post(serverUrl + '/findUsers',
  //         body: {"username": user, "password": pass});
  //     if (response.statusCode == 200) {
  //       final result = userFromJson(response.body);

  //       return result;
  //     } else {
  //       throw Exception("Error");
  //     }
  //   } catch (e) {
  //     // throw Exception(e.toList());
  //   }
  // }

  static Future<bool> runTrigger(String url) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String _url = 'http://' + prefs.getString('ip') + url;
    // http://192.168.100.80/LED=ON
    try {
      final response = await http.get(_url);
      if (response.statusCode == 200) {
        //final result = userFromJson(response.body);

        return true;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      // throw Exception(e.toList());
    }
  }
}
