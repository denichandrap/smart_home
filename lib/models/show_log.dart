// To parse this JSON data, do
//
//     final showLog = showLogFromJson(jsonString);

import 'dart:convert';

List<ShowLog> showLogFromJson(String str) =>
    List<ShowLog>.from(json.decode(str).map((x) => ShowLog.fromJson(x)));

String showLogToJson(List<ShowLog> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShowLog {
  ShowLog({
    this.id,
    this.kodeGrup,
    this.trigger,
    this.dtArduino,
    this.dtServer,
  });

  int id;
  String kodeGrup;
  String trigger;
  DateTime dtArduino;
  DateTime dtServer;

  factory ShowLog.fromJson(Map<String, dynamic> json) => ShowLog(
        id: json["id"],
        kodeGrup: json["kode_grup"],
        trigger: json["trigger"],
        dtArduino: DateTime.parse(json["dt_arduino"]),
        dtServer: DateTime.parse(json["dt_server"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode_grup": kodeGrup,
        "trigger": trigger,
        "dt_arduino": dtArduino.toIso8601String(),
        "dt_server": dtServer.toIso8601String(),
      };
}
