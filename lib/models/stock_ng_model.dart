import 'package:intl/intl.dart';
import 'dart:convert';

Sngp sngpFromJson(String str) => Sngp.fromJson(json.decode(str));
String sngpToJson(Sngp data) => jsonEncode(data.toJson());
List<StockNGModel> stockModelNGFromJson(List data) => List<StockNGModel>.from(
      data.map(
        (x) => StockNGModel.fromJson(x),
      ),
    );
List<QtyNGModel> scrabModelNGFromJson(List data) => List<QtyNGModel>.from(
      data.map(
        (x) => QtyNGModel.fromJson(x),
      ),
    );

class Sngp {
  Sngp({
    required this.status,
    required this.list,
  });

  bool status;
  ListClassSummaryNG list;

  factory Sngp.fromJson(Map<String, dynamic> json) => Sngp(
        status: json["status"],
        list: ListClassSummaryNG.fromJson(json["list"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "list": list.toJson(),
      };
}

class ListClassSummaryNG {
  ListClassSummaryNG({
    required this.data,
  });

  List<StockNGModel> data;

  factory ListClassSummaryNG.fromJson(Map<String, dynamic> json) =>
      ListClassSummaryNG(
        data: List<StockNGModel>.from(
            json["data"].map((x) => StockNGModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class StockNGModel {
  int id;
  int part_id;
  String part_number;
  String part_name;
  List<QtyNGModel> qty_ng;
  int total;
  DateTime created_at;
  DateTime updated_at;

  StockNGModel({
    required this.id,
    required this.part_id,
    required this.part_number,
    required this.part_name,
    required this.qty_ng,
    required this.total,
    required this.created_at,
    required this.updated_at,
  });

  factory StockNGModel.fromJson(Map<String, dynamic> json) => StockNGModel(
        id: json["id"],
        part_id: json["part_id"],
        part_number: json["part_number"],
        part_name: json["part_name"],
        qty_ng: json["qty_ng"]
            .map<QtyNGModel>((qty_ng) => QtyNGModel.fromJson(qty_ng))
            .toList(),
        total: json["total"],
        created_at:
            DateFormat('yyyy-MM-dd').parse(json["created_at"] as String),
        updated_at:
            DateFormat('yyyy-MM-dd').parse(json["updated_at"] as String),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "part_id": part_id,
        "part_number": part_number,
        "part_name": part_name,
        "qty_ng": qty_ng.map((qty_ng) => qty_ng.toJson()).toList(),
        "total": total,
        "created_at": created_at.toString(),
        "updated_at": updated_at.toString(),
      };
}

class QtyNGModel {
  String name;
  int total;
  QtyNGModel({
    required this.name,
    required this.total,
  });

  factory QtyNGModel.fromJson(Map<String, dynamic> json) => QtyNGModel(
        name: json["name"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "total": total,
      };
}
