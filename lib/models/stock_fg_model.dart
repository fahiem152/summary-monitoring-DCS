List<StockFGModel> stockModelFromJson(List data) => List<StockFGModel>.from(
      data.map(
        (x) => StockFGModel.fromJson(x),
      ),
    );

class StockFGModel {
  StockFGModel({
    required this.name,
    required this.value,
    required this.id,
  });

  String name;
  int value;
  String id;

  factory StockFGModel.fromJson(Map<String, dynamic> json) => StockFGModel(
        name: json["name"],
        value: json["value"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
        "id": id,
      };
}
