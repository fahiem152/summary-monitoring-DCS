// To parse this JSON data, do
//
//     final Pfgivo = PfgivoFromJson(jsonString);

import 'dart:convert';

Pfgivo pfgivoFromJson(String str) => Pfgivo.fromJson(json.decode(str));

String pfgivoToJson(Pfgivo data) => json.encode(data.toJson());

List<DataPfgivo> pfgivoModelFromJson(List data) => List<DataPfgivo>.from(
      data.map(
        (x) => DataPfgivo.fromJson(x),
      ),
    );

class Pfgivo {
  Pfgivo({
    required this.status,
    required this.data,
  });

  bool status;
  List<DataPfgivo> data;

  factory Pfgivo.fromJson(Map<String, dynamic> json) => Pfgivo(
        status: json["status"],
        data: List<DataPfgivo>.from(
            json["data"].map((x) => DataPfgivo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataPfgivo {
  DataPfgivo({
    required this.datumIn,
    required this.createdAt,
    required this.out,
    required this.stock,
    required this.id,
  });

  DateTime createdAt;
  int datumIn;
  int out;
  int stock;
  String id;

  factory DataPfgivo.fromJson(Map<String, dynamic> json) => DataPfgivo(
        createdAt: DateTime.parse(json["createdAt"]),
        datumIn: json["in"],
        out: json["out"],
        stock: json["stock"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "in": datumIn,
        "out": out,
        "stock": stock,
        "id": id,
      };
}
