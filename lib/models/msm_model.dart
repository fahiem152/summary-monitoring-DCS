class MsmModel {
  MsmModel({
    required this.id,
    required this.actual,
    required this.supplier,
    required this.batchMaterialName,
    required this.type,
    required this.qtyMin,
    required this.qtyMax,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int actual;
  String supplier;
  String batchMaterialName;
  String type;
  int qtyMin;
  int qtyMax;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory MsmModel.fromJson(Map<String, dynamic> json) => MsmModel(
        id: json["id"],
        actual: json["actual"],
        supplier: json["supplier"],
        batchMaterialName: json["batch_material_name"],
        type: json["type"],
        qtyMin: json["qty_min"],
        qtyMax: json["qty_max"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "actual": actual,
        "supplier": supplier,
        "batch_material_name": batchMaterialName,
        "type": type,
        "qty_min": qtyMin,
        "qty_max": qtyMax,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
