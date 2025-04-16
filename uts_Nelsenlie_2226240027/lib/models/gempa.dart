class Gempa {
  final String tanggal;
  final String jam;
  final String magnitude;
  final String kedalaman;
  final String lintang;
  final String bujur;
  final String wilayah;
  final String potensi;

  Gempa({
    required this.tanggal,
    required this.jam,
    required this.magnitude,
    required this.kedalaman,
    required this.lintang,
    required this.bujur,
    required this.wilayah,
    required this.potensi,
  });

  factory Gempa.fromJson(Map<String, dynamic> json) {
    final gempa = json['Infogempa']['gempa'];
    return Gempa(
      tanggal: gempa['Tanggal'],
      jam: gempa['Jam'],
      magnitude: gempa['Magnitude'],
      kedalaman: gempa['Kedalaman'],
      lintang: gempa['Lintang'],
      bujur: gempa['Bujur'],
      wilayah: gempa['Wilayah'],
      potensi: gempa['Potensi'],
    );
  }
}
