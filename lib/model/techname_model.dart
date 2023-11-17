class TechModel {
  String? id;
  String? name;
  String? batch;
  String? phone;
  String? domain;

  TechModel(
      {required this.id,
      required this.name,
      required this.batch,
      required this.phone,
      required this.domain});

  factory TechModel.fromMap(Map<String, dynamic> map, String id) {
    return TechModel(
      id: id,
      name: map['name'] ?? "",
      batch: map['batch'] ?? "",
      phone: map['phone'].toString(),
      domain: map['domain'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'batch': batch, 'phone': phone, 'domain': domain};
  }
}
