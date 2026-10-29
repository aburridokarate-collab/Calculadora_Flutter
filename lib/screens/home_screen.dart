import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String display = '0';
  double firstNumber = 0;
  double secondNumber = 0;
  String operation = '';

  void onButtonPressed(String value) {
    setState(() {
      if (display == 'Error') {
        display = '0';
      }

      if (value == 'CE') {
        display = '0';
        firstNumber = 0;
        secondNumber = 0;
        operation = '';
      } else if (value == 'C') {
        if (display.length > 1) {
          display = display.substring(0, display.length - 1);
        } else {
          display = '0';
        }
      } else if (value == '+' || value == '-' || value == '*' || value == '/') {
        firstNumber = double.tryParse(display) ?? 0;
        operation = value;
        display = '0';
      } else if (value == '.') {
        if (!display.contains('.')) {
          display = display + value;
        }
      } else if (value == '=') {
        if (operation.isNotEmpty) {
          secondNumber = double.tryParse(display) ?? 0;

          if (operation == '+') {
            display = (firstNumber + secondNumber).toString();
          } else if (operation == '-') {
            display = (firstNumber - secondNumber).toString();
          } else if (operation == '*') {
            display = (firstNumber * secondNumber).toString();
          } else if (operation == '/') {
            if (secondNumber != 0) {
              display = (firstNumber / secondNumber).toString();
            } else {
              display = 'Error';
            }
          }

          firstNumber = 0;
          secondNumber = 0;
          operation = '';

          if (display.endsWith('.0')) {
            display = display.substring(0, display.length - 2);
          }
        }
      } else {
        if (display == '0') {
          display = value;
        } else {
          display = display + value;
        }
      }
    });
  }

  Widget buildButton(String text, Color bgColor, {Color textColor = Colors.white, int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Container(
        margin: EdgeInsets.all(4),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            padding: EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () => onButtonPressed(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 22,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Calculadora'),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.info);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(24),
              child: Text(
                display,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Row(
            children: [
              buildButton('C', Colors.orange, textColor: Colors.white),
              buildButton('CE', Colors.redAccent, textColor: Colors.white),
              buildButton('/', Colors.blue, textColor: Colors.white),
              buildButton('*', Colors.blue, textColor: Colors.white),
            ],
          ),
          Row(
            children: [
              buildButton('7', Colors.grey.shade300, textColor: Colors.black),
              buildButton('8', Colors.grey.shade300, textColor: Colors.black),
              buildButton('9', Colors.grey.shade300, textColor: Colors.black),
              buildButton('-', Colors.blue, textColor: Colors.white),
            ],
          ),
          Row(
            children: [
              buildButton('4', Colors.grey.shade300, textColor: Colors.black),
              buildButton('5', Colors.grey.shade300, textColor: Colors.black),
              buildButton('6', Colors.grey.shade300, textColor: Colors.black),
              buildButton('+', Colors.blue, textColor: Colors.white),
            ],
          ),
          Row(
            children: [
              buildButton('1', Colors.grey.shade300, textColor: Colors.black),
              buildButton('2', Colors.grey.shade300, textColor: Colors.black),
              buildButton('3', Colors.grey.shade300, textColor: Colors.black),
              buildButton('.', Colors.grey.shade300, textColor: Colors.black),
            ],
          ),
          Row(
            children: [
              buildButton('0', Colors.grey.shade300, textColor: Colors.black, flex: 2),
              buildButton('=', Colors.green, textColor: Colors.white, flex: 2),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
