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
  KodeGrup kodeGrup;
  Trigger trigger;
  DateTime dtArduino;
  DateTime dtServer;

  factory ShowLog.fromJson(Map<String, dynamic> json) => ShowLog(
        id: json["id"],
        kodeGrup: kodeGrupValues.map[json["kode_grup"]],
        trigger: triggerValues.map[json["trigger"]],
        dtArduino: DateTime.parse(json["dt_arduino"]),
        dtServer: DateTime.parse(json["dt_server"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode_grup": kodeGrupValues.reverse[kodeGrup],
        "trigger": triggerValues.reverse[trigger],
        "dt_arduino": dtArduino.toIso8601String(),
        "dt_server": dtServer.toIso8601String(),
      };
}

enum KodeGrup { PR010820_0001 }

final kodeGrupValues = EnumValues({"PR010820-0001": KodeGrup.PR010820_0001});

enum Trigger { APP, TOMBOL, SCHEDULE, WEB }

final triggerValues = EnumValues({
  "app": Trigger.APP,
  "schedule": Trigger.SCHEDULE,
  "tombol": Trigger.TOMBOL,
  "web": Trigger.WEB
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
