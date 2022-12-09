import 'dart:convert';

MonRak monRakFromJson(String str) => MonRak.fromJson(json.decode(str));

String monRakToJson(MonRak data) => json.encode(data.toJson());

List<DataRak> dataRakModelFromJson(List data) => List<DataRak>.from(
      data.map(
        (x) => DataRak.fromJson(x),
      ),
    );

class MonRak {
  MonRak({
    required this.status,
    required this.available,
    required this.used,
    required this.data,
    required this.jmlhsupplier,
  });

  bool status;
  int available;
  int used;
  int jmlhsupplier;
  List<DataRak> data;

  factory MonRak.fromJson(Map<String, dynamic> json) => MonRak(
        status: json["status"],
        available: json["available"],
        used: json["used"],
        jmlhsupplier: json["jmlhsupplier"],
        data: List<DataRak>.from(json["data"].map((x) => DataRak.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "available": available,
        "used": used,
        "jmlhsupplier": jmlhsupplier,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataRak {
  DataRak({
    required this.createdAt,
    required this.suplier,
    required this.value,
    required this.id,
  });

  DateTime createdAt;
  String suplier;
  int value;
  String id;

  factory DataRak.fromJson(Map<String, dynamic> json) => DataRak(
        createdAt: DateTime.parse(json["createdAt"]),
        suplier: json["suplier"],
        value: json["value"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "suplier": suplier,
        "value": value,
        "id": id,
      };
}
