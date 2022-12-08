List<Mivo> mivoModelFromJson(List data) => List<Mivo>.from(
      data.map(
        (x) => Mivo.fromJson(x),
      ),
    );

class Mivo {
  Mivo({
    required this.datumIn,
    required this.out,
    required this.stock,
    required this.id,
  });

  int datumIn;
  int out;
  int stock;
  String id;

  factory Mivo.fromJson(Map<String, dynamic> json) => Mivo(
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
