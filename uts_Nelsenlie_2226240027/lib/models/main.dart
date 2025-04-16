import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/gempa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Info Gempa BMKG',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const GempaPage(),
    );
  }
}

class GempaPage extends StatefulWidget {
  const GempaPage({super.key});

  @override
  State<GempaPage> createState() => _GempaPageState();
}

class _GempaPageState extends State<GempaPage> {
  Gempa? _gempa;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    fetchGempa();
  }

  Future<void> fetchGempa() async {
    final url = Uri.parse(
      'https://data.bmkg.go.id/DataMKG/TEWS/autogempa.json',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _gempa = Gempa.fromJson(data);
        _loading = false;
      });
    } else {
      throw Exception('Gagal mengambil data gempa');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Informasi Gempa Terkini')),
      body:
          _loading
              ? const Center(child: CircularProgressIndicator())
              : _gempa == null
              ? const Center(child: Text('Tidak ada data gempa'))
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Waktu: ${_gempa!.tanggal} ${_gempa!.jam}'),
                    Text('Magnitude: ${_gempa!.magnitude}'),
                    Text('Kedalaman: ${_gempa!.kedalaman}'),
                    Text('Lokasi: ${_gempa!.lintang}, ${_gempa!.bujur}'),
                    Text('Wilayah: ${_gempa!.wilayah}'),
                    Text('Potensi: ${_gempa!.potensi}'),
                  ],
                ),
              ),
    );
  }
}
