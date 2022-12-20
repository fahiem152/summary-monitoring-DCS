import 'dart:convert';

Mivo mivoFromJson(String str) => Mivo.fromJson(json.decode(str));

String mivoToJson(Mivo data) => json.encode(data.toJson());

List<DataMivo> mivoModelFromJson(List data) => List<DataMivo>.from(
      data.map(
        (x) => DataMivo.fromJson(x),
      ),
    );

class Mivo {
  Mivo({
    required this.status,
    required this.list,
  });

  bool status;
  ListClass list;

  factory Mivo.fromJson(Map<String, dynamic> json) => Mivo(
        status: json["status"],
        list: ListClass.fromJson(json["list"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "list": list.toJson(),
      };
}

class ListClass {
  ListClass({
    required this.data,
  });

  List<DataMivo> data;

  factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
        data:
            List<DataMivo>.from(json["data"].map((x) => DataMivo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataMivo {
  DataMivo({
    required this.id,
    required this.materialId,
    required this.materialIn,
    required this.materialOut,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int materialId;
  int materialIn;
  int materialOut;
  DateTime createdAt;
  DateTime updatedAt;

  factory DataMivo.fromJson(Map<String, dynamic> json) => DataMivo(
        id: json["id"],
        materialId: json["material_id"],
        materialIn: json["material_in"],
        materialOut: json["material_out"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "material_id": materialId,
        "material_in": materialIn,
        "material_out": materialOut,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}













// import 'dart:convert';

// Mivo mivoFromJson(String str) => Mivo.fromJson(json.decode(str));

// String mivoToJson(Mivo data) => json.encode(data.toJson());

// List<DataMivo> stockModelFromJson(List data) => List<DataMivo>.from(
//       data.map(
//         (x) => DataMivo.fromJson(x),
//       ),
//     );

// class Mivo {
//   Mivo({
//     required this.status,
//     required this.data,
//   });

//   bool status;
//   List<DataMivo> data;

//   factory Mivo.fromJson(Map<String, dynamic> json) => Mivo(
//         status: json["status"],
//         data:
//             List<DataMivo>.from(json["data"].map((x) => DataMivo.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };
// }

// class DataMivo {
//   DataMivo({
//     required this.datumIn,
//     required this.out,
//     required this.stock,
//     required this.id,
//   });

//   int datumIn;
//   int out;
//   int stock;
//   String id;

//   factory DataMivo.fromJson(Map<String, dynamic> json) => DataMivo(
//         datumIn: json["in"],
//         out: json["out"],
//         stock: json["stock"],
//         id: json["id"],
//       );

//   Map<String, dynamic> toJson() => {
//         "in": datumIn,
//         "out": out,
//         "stock": stock,
//         "id": id,
//       };
// }
