// List<StockNGModel> stockModelNGFromJson(List data) => List<StockNGModel>.from(
//       data.map(
//         (x) => StockNGModel.fromJson(x),
//       ),
//     );
// List<ScrabNGModel> scrabModelNGFromJson(List data) => List<ScrabNGModel>.from(
//       data.map(
//         (x) => ScrabNGModel.fromJson(x),
//       ),
//     );

// class StockNGModel {
//   String material;
//   String material_number;
//   List<ScrabNGModel> scrab_ng;
//   StockNGModel({
//     required this.material,
//     required this.material_number,
//     required this.scrab_ng,
//   });
//   factory StockNGModel.fromJson(Map<String, dynamic> json) => StockNGModel(
//         material: json["material"],
//         material_number: json["material_number"],
//         scrab_ng: json['scrab_ng']
//             .map<ScrabNGModel>((scrab_ng) => ScrabNGModel.fromJson(scrab_ng))
//             .toList(),
//       );

//   Map<String, dynamic> toJson() => {
//         "material": material,
//         "material_number": material_number,
//         "scrab_ng": scrab_ng.map((scarb_ng) => scarb_ng.toJson()).toList(),
//       };

//   int getQuantityNG() {
//     return scrab_ng.fold(
//         0, (previousValue, element) => previousValue + element.value);
//   }
// }

// class ScrabNGModel {
//   String name;
//   int value;
//   ScrabNGModel({
//     required this.name,
//     required this.value,
//   });

//   factory ScrabNGModel.fromJson(Map<String, dynamic> json) => ScrabNGModel(
//         name: json["name"],
//         value: json["value"],
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "value": value,
//       };
// }

import 'package:intl/intl.dart';

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

class StockNGModel {
  int id;
  int material_id;
  String material_number;
  String material_name;
  List<QtyNGModel> qty_ng;
  int total;
  DateTime created_at;
  DateTime updated_at;

  StockNGModel({
    required this.id,
    required this.material_id,
    required this.material_number,
    required this.material_name,
    required this.qty_ng,
    required this.total,
    required this.created_at,
    required this.updated_at,
  });

  factory StockNGModel.fromJson(Map<String, dynamic> json) => StockNGModel(
      id: json["id"],
      material_id: json["material_id"],
      material_number: json["material_number"],
      material_name: json["material_name"],
      qty_ng: json["qty_ng"]
          .map<QtyNGModel>((qty_ng) => QtyNGModel.fromJson(qty_ng))
          .toList(),
      total: json["total"],
      created_at: DateFormat('yyyy-MM-dd').parse(json["created_at"] as String),
      updated_at: DateFormat('yyyy-MM-dd').parse(json["updated_at"] as String)
      // updated_at: DateTime.parse(json["updated_at"] as String),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "material_id": material_id,
        "material_number": material_number,
        "material_name": material_name,
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
