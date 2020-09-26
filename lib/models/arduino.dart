// To parse this JSON data, do
//
//     final arduino = arduinoFromJson(jsonString);

import 'dart:convert';

List<Arduino> arduinoFromJson(String str) =>
    List<Arduino>.from(json.decode(str).map((x) => Arduino.fromJson(x)));

String arduinoToJson(List<Arduino> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Arduino {
  Arduino({
    this.id,
    this.namaMesin,
    this.tipe,
    this.icon,
    this.url,
    this.tabel,
    this.timestamp,
  });

  int id;
  String namaMesin;
  String tipe;
  int icon;
  String url;
  String tabel;
  DateTime timestamp;

  factory Arduino.fromJson(Map<String, dynamic> json) => Arduino(
        id: json["id"],
        namaMesin: json["Nama_mesin"],
        tipe: json["tipe"],
        icon: json["icon"],
        url: json["url"],
        tabel: json["tabel"],
        timestamp: DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Nama_mesin": namaMesin,
        "tipe": tipe,
        "icon": icon,
        "url": url,
        "tabel": tabel,
        "timestamp": timestamp.toIso8601String(),
      };
}
