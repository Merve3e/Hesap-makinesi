
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hesaplama Uygulaması',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController _sayi1Controller = TextEditingController();
  final TextEditingController _sayi2Controller = TextEditingController();
  final TextEditingController _islemController = TextEditingController();
  String _sonuc = "Sonuç:";

  void _hesapla() {
    setState(() {
      final sayi1 = double.tryParse(_sayi1Controller.text.trim());
      final sayi2 = double.tryParse(_sayi2Controller.text.trim());
      final islem = _islemController.text.trim();

      if (sayi1 == null || sayi2 == null || islem.isEmpty) {
        _sonuc = "Lütfen geçerli girişler yapın!";
        return;
      }

      switch (islem) {
        case "+":
          _sonuc = "Sonuç: ${sayi1 + sayi2}";
          break;
        case "-":
          _sonuc = "Sonuç: ${sayi1 - sayi2}";
          break;
        case "*":
          _sonuc = "Sonuç: ${sayi1 * sayi2}";
          break;
        case "/":
          if (sayi2 != 0) {
            _sonuc = "Sonuç: ${sayi1 / sayi2}";
          } else {
            _sonuc = "Bölme işleminde ikinci sayı sıfır olamaz!";
          }
          break;
        default:
          _sonuc = "Geçersiz işlem. (+, -, *, / girin)";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hesaplama Uygulaması"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _sayi1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Birinci sayıyı girin",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _sayi2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "İkinci sayıyı girin",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _islemController,
              maxLength: 1,
              decoration: const InputDecoration(
                labelText: "+ - * / işlem girin",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _hesapla,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Mavi düğme
              ),
              child: const Text("Hesapla"),
            ),
            const SizedBox(height: 20),
            Text(
              _sonuc,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

