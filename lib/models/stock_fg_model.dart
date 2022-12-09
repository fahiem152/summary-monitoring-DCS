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

class TabelStckFGModel {
  TabelStckFGModel({
    required this.partNumber,
    required this.name,
    required this.min,
    required this.max,
    required this.inbound,
    required this.outbound,
    required this.sisa,
  });

  String partNumber;
  String name;
  int min;
  int max;
  String inbound;
  String outbound;
  String sisa;

  factory TabelStckFGModel.fromJson(Map<String, dynamic> json) =>
      TabelStckFGModel(
        partNumber: json["part_number"],
        name: json["name"],
        min: json["min"],
        max: json["max"],
        inbound: json["inbound"],
        outbound: json["outbound"],
        sisa: json["sisa"],
      );

  Map<String, dynamic> toJson() => {
        "part_number": partNumber,
        "name": name,
        "min": min,
        "max": max,
        "inbound": inbound,
        "outbound": outbound,
        "sisa": sisa,
      };
}