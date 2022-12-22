// List<PLanActualModel> planActualModelFromJson(List data) =>
//     List<PLanActualModel>.from(
//       data.map(
//         (x) => PLanActualModel.fromJson(x),
//       ),
//     );

// class PLanActualModel {
//   PLanActualModel({
//     required this.name,
//     required this.value,
//   });

//   String name;
//   int value;

//   factory PLanActualModel.fromJson(Map<String, dynamic> json) =>
//       PLanActualModel(
//         name: json["name"],
//         value: json["value"],
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "value": value,
//       };
// }

// To parse this JSON data, do
//
//     final sdpa = sdpaFromJson(jsonString);

import 'dart:convert';

Sdpa sdpaFromJson(String str) => Sdpa.fromJson(json.decode(str));

String sdpaToJson(Sdpa data) => json.encode(data.toJson());

List<PLanActualModel> planActualModelFromJson(List data) =>
    List<PLanActualModel>.from(
      data.map(
        (x) => PLanActualModel.fromJson(x),
      ),
    );

List<Achieved> achievedModelFromJson(List data) => List<Achieved>.from(
      data.map(
        (x) => Achieved.fromJson(x),
      ),
    );

class Sdpa {
  Sdpa({
    required this.data,
  });

  List<PLanActualModel> data;

  factory Sdpa.fromJson(Map<String, dynamic> json) => Sdpa(
        data: List<PLanActualModel>.from(
            json["data"].map((x) => PLanActualModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PLanActualModel {
  PLanActualModel({
    required this.id,
    required this.planned,
    required this.achieved,
    required this.gap,
    required this.percentage,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  List<Achieved> planned;
  List<Achieved> achieved;
  List<Achieved> gap;
  List<Achieved> percentage;
  DateTime createdAt;
  DateTime updatedAt;

  factory PLanActualModel.fromJson(Map<String, dynamic> json) =>
      PLanActualModel(
        id: json["id"],
        planned: List<Achieved>.from(
            json["planned"].map((x) => Achieved.fromJson(x))),
        achieved: List<Achieved>.from(
            json["achieved"].map((x) => Achieved.fromJson(x))),
        gap: List<Achieved>.from(json["gap"].map((x) => Achieved.fromJson(x))),
        percentage: List<Achieved>.from(
            json["percentage"].map((x) => Achieved.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "planned": List<dynamic>.from(planned.map((x) => x.toJson())),
        "achieved": List<dynamic>.from(achieved.map((x) => x.toJson())),
        "gap": List<dynamic>.from(gap.map((x) => x.toJson())),
        "percentage": List<dynamic>.from(percentage.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Achieved {
  Achieved({
    required this.name,
    required this.value,
  });

  String name;
  double value;

  factory Achieved.fromJson(Map<String, dynamic> json) => Achieved(
        name: json["name"],
        value: json["value"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}
