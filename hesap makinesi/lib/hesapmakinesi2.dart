
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
      title: 'Hesap Makinesi',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _display = "";
  String _input = "";
  double? _firstNumber;
  String? _operation;

  void _buttonPressed(String value) {
    setState(() {
      if (value == "=") {
        if (_firstNumber != null && _operation != null && _input.isNotEmpty) {
          double secondNumber = double.parse(_input);
          double result = 0;

          switch (_operation) {
            case "+":
              result = _firstNumber! + secondNumber;
              break;
            case "-":
              result = _firstNumber! - secondNumber;
              break;
            case "*":
              result = _firstNumber! * secondNumber;
              break;
            case "/":
              if (secondNumber != 0) {
                result = _firstNumber! / secondNumber;
              } else {
                _display = "Hata! Sıfıra bölme.";
                _input = "";
                return;
              }
              break;
          }

          _display = result.toString();
          _input = "";
          _firstNumber = null;
          _operation = null;
        }
      } else if (value == "+" || value == "-" || value == "*" || value == "/") {
        if (_input.isNotEmpty) {
          _firstNumber = double.parse(_input);
          _operation = value;
          _input = "";
        }
      } else {
        _input += value;
        _display = _input;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hesap Makinesi"),
      ),
      body: Column(
        children: [

          Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerRight,
            child: Text(
              _display,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),

          Expanded(
            child: Container(
              color: Colors.grey.shade200,
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  childAspectRatio: 1.5,
                ),
                itemCount: 16,
                itemBuilder: (context, index) {

                  final buttons = [
                    "7", "8", "9", "/",
                    "4", "5", "6", "*",
                    "1", "2", "3", "-",
                    "0", ".", "+", "="
                  ];

                  return ElevatedButton(
                    onPressed: () => _buttonPressed(buttons[index]),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      buttons[index],
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
