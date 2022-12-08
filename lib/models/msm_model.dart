class MsmModel {
  MsmModel({
    required this.type,
    required this.partName,
    required this.weight,
  });

  String type;
  String partName;
  int weight;

  factory MsmModel.fromJson(Map<String, dynamic> json) => MsmModel(
        type: json["type"],
        partName: json["part_name"],
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "part_name": partName,
        "weight": weight,
      };
}
