// To parse this JSON data, do
//
//     final detailHeader = detailHeaderFromJson(jsonString);

import 'dart:convert';

List<DetailHeader> detailHeaderFromJson(String str) => List<DetailHeader>.from(
    json.decode(str).map((x) => DetailHeader.fromJson(x)));

String detailHeaderToJson(List<DetailHeader> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DetailHeader {
  DetailHeader({
    this.id,
    this.kodeGrup,
    this.dtGantiArduino,
    this.dtGantiServer,
    this.count,
  });

  int id;
  String kodeGrup;
  DateTime dtGantiArduino;
  DateTime dtGantiServer;
  int count;

  factory DetailHeader.fromJson(Map<String, dynamic> json) => DetailHeader(
        id: json["id"],
        kodeGrup: json["kode_grup"],
        dtGantiArduino: DateTime.parse(json["dt_ganti_arduino"]),
        dtGantiServer: DateTime.parse(json["dt_ganti_server"]),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode_grup": kodeGrup,
        "dt_ganti_arduino": dtGantiArduino.toIso8601String(),
        "dt_ganti_server": dtGantiServer.toIso8601String(),
        "count": count,
      };
}
