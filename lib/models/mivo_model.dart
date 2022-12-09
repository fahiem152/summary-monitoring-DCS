import 'dart:convert';

Mivo mivoFromJson(String str) => Mivo.fromJson(json.decode(str));

String mivoToJson(Mivo data) => json.encode(data.toJson());

List<DataMivo> stockModelFromJson(List data) => List<DataMivo>.from(
      data.map(
        (x) => DataMivo.fromJson(x),
      ),
    );

class Mivo {
  Mivo({
    required this.status,
    required this.data,
  });

  bool status;
  List<DataMivo> data;

  factory Mivo.fromJson(Map<String, dynamic> json) => Mivo(
        status: json["status"],
        data:
            List<DataMivo>.from(json["data"].map((x) => DataMivo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataMivo {
  DataMivo({
    required this.datumIn,
    required this.out,
    required this.stock,
    required this.id,
  });

  int datumIn;
  int out;
  int stock;
  String id;

  factory DataMivo.fromJson(Map<String, dynamic> json) => DataMivo(
        datumIn: json["in"],
        out: json["out"],
        stock: json["stock"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "in": datumIn,
        "out": out,
        "stock": stock,
        "id": id,
      };
}
