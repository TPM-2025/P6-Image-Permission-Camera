import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker _picker = ImagePicker();
  XFile? image;

  // Fungsi buat mengambil gambar
  Future<void> _getImage(bool isCamera) async {
    // Menyimpan gambar ke dalam variabel "image"
    image = await _picker.pickImage(
      // Mengecek apakah gambarnya bersumber dari camera atau gallery
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );

    // Meng-update state (tampilan)
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              // Tombol camera
              ElevatedButton(
                onPressed: () {
                  // Memanggil fungsi _getImage dengan parameter false
                  // Kenapa true? karena gambar diambil dari camera
                  _getImage(true);
                },
                child: Text("Open Camera"),
              ),
              SizedBox(height: 4),

              // Tombol gallery
              ElevatedButton(
                onPressed: () {
                  // Memanggil fungsi _getImage dengan parameter false
                  // Kenapa false? karena gambar diambil dari gallery
                  _getImage(false);
                },
                child: Text("Gallery"),
              ),
              SizedBox(height: 24),
              Text("Hasil Gambar"),
              SizedBox(height: 8),

              // Mengecek apakah ada gambar atau ga
              // Kalo ada tampilkan gambar, kalo tidak ada tampilkan tulisan "belum ada gambar"
              image != null
                  // Mengecek menggunakan web atau android, kIsWeb = true artinya pake Web
                  ? (kIsWeb
                      ? Image.network(image!.path)
                      : Image.file(File(image!.path)))
                  : Text(
                    "Belum ada gambar.",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
