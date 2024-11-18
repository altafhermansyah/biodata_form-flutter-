class ItemModel {
  final int id;
  final String kode;
  final String nama;
  final int harga;

  ItemModel({
    required this.id,
    required this.kode,
    required this.nama,
    required this.harga,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'] ?? 0,
      kode: json['kode'] ?? '',
      nama: json['nama'] ?? '',
      harga: json['harga'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'kode': kode,
    'nama': nama,
    'harga': harga,
  };
}
