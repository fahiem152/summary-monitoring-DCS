List<StockNGModel> stockModelNGFromJson(List data) => List<StockNGModel>.from(
      data.map(
        (x) => StockNGModel.fromJson(x),
      ),
    );

class StockNGModel {
  String material;
  String material_number;
  List<ScrabNGModel> scrab_ng;
  StockNGModel({
    required this.material,
    required this.material_number,
    required this.scrab_ng,
  });
  factory StockNGModel.fromJson(Map<String, dynamic> json) => StockNGModel(
      material: json["material"],
      material_number: json["material_number"],
      scrab_ng: json['scrab_ng']
          .map<ScrabNGModel>((scrab_ng) => ScrabNGModel.fromJson(scrab_ng))
          .toList());

  Map<String, dynamic> toJson() => {
        "material": material,
        "material_number": material_number,
        "scrab_ng": scrab_ng.map((scarb_ng) => scarb_ng.toJson()).toList(),
      };
}

class ScrabNGModel {
  String name;
  int value;
  ScrabNGModel({
    required this.name,
    required this.value,
  });

  factory ScrabNGModel.fromJson(Map<String, dynamic> json) => ScrabNGModel(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}
