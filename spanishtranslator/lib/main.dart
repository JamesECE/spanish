import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number to Spanish Word',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: NumberToSpanishConverter(),
    );
  }
}

class NumberToSpanishConverter extends StatefulWidget {
  @override
  _NumberToSpanishConverterState createState() =>
      _NumberToSpanishConverterState();
}

class _NumberToSpanishConverterState extends State<NumberToSpanishConverter> {
  TextEditingController _numberController = TextEditingController();
  String _result = "";

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  void _convertToSpanish() {
    setState(() {
      _result = ""; // Reset the result
    });

    // Get the user input
    String input = _numberController.text.trim();
    if (input.isEmpty) return;

    try {
      int number = int.parse(input);
      if (number < 1 || number > 1000000) {
        setState(() {
          _result = "Number must be between 1 and 10000";
        });
      } else {
        setState(() {
          _result = _convertNumberToSpanish(number);
        });
      }
    } catch (e) {
      setState(() {
        _result = "Invalid input";
      });
    }
  }

  String _convertNumberToSpanish(int number) {
    if (number == 0) {
      return "cero";
    }

    final List<String> units = [
      "",
      "uno",
      "dos",
      "tres",
      "cuatro",
      "cinco",
      "seis",
      "siete",
      "ocho",
      "nueve"
          "diez"
    ];

    final List<String> teens = [
      "",
      "once",
      "doce",
      "trece",
      "catorce",
      "quince",
      "dieciséis",
      "diecisiete",
      "dieciocho",
      "diecinueve"
    ];

    final List<String> tens = [
      "",
      "diez",
      "veinte",
      "treinta",
      "cuarenta",
      "cincuenta",
      "sesenta",
      "setenta",
      "ochenta",
      "noventa"
    ];

    String result = "";

    if (number >= 1000000) {
      int millions = (number / 1000000).floor();
      result += "${_convertNumberToSpanish(millions)} millón";
      number %= 1000000;
      if (number > 0) {
        result += " ";
      } else {
        return result;
      }
    }

    if (number >= 100000) {
      int hundredThousands = (number / 100000).floor();
      result += "${units[hundredThousands]} cien mil";
      number %= 100000;
      if (number > 0) {
        result += " ";
      } else {
        return result;
      }
    }

    if (number >= 10000) {
      int tenThousands = (number / 10000).floor();
      if (tenThousands == 1) {
        result += "diez mil";
      } else {
        result += "${tens[tenThousands]} mil";
      }
      number %= 10000;
      if (number > 0) {
        result += " ";
      } else {
        return result;
      }
    }

    if (number >= 1000) {
      int thousands = (number / 1000).floor();
      result += "${units[thousands]} mil";
      number %= 1000;
      if (number > 0) {
        result += " ";
      } else {
        return result;
      }
    }

    if (number >= 100) {
      int hundreds = (number / 100).floor();
      result += "${units[hundreds]} cientos";
      number %= 100;
      if (number > 0) {
        result += " ";
      } else {
        return result;
      }
    }

    if (number > 0) {
      if (number == 10) {
        result += "diez";
      } else if (number < 10) {
        result += "${units[number]}";
      } else if (number < 20) {
        result += "${teens[number - 10]}";
      } else {
        int tensDigit = (number / 10).floor();
        int unitsDigit = number % 10;
        result += "${tens[tensDigit]}";
        if (unitsDigit > 0) {
          result += " y ${units[unitsDigit]}";
        }
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number to Spanish Translator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter a number (1 - 1,000,000)',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertToSpanish,
              child: Text('Translate'),
            ),
            SizedBox(height: 20),
            if (_result.isNotEmpty)
              Text(
                _result,
                style: TextStyle(fontSize: 20),
              ),
          ],
        ),
      ),
    );
  }
}
