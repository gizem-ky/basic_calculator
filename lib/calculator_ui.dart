import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _displayText = '';
  final List<String> _operations = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Calculator')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  _displayText,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton('7'),
                  _buildButton('8'),
                  _buildButton('9'),
                  _buildButton('+'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton('4'),
                  _buildButton('5'),
                  _buildButton('6'),
                  _buildButton('-'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton('1'),
                  _buildButton('2'),
                  _buildButton('3'),
                  _buildButton('x'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton('C'),
                  _buildButton('0'),
                  _buildButton('='),
                  _buildButton('/'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (text == 'C') {
            _displayText = '';
            _operations.clear();
          } else if (text == '=') {
            _operations.add(_displayText);
            _displayText = _evaluate();
            _operations.clear();
          } else {
            _displayText += text;
            if (_operations.isNotEmpty && _operations.last != '+' && _operations.last != '-' && _operations.last != '*' && _operations.last != '/') {
              _operations.last += text;
            } else {
              _operations.add(text);
            }
          }
        });
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(20),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }

  String _evaluate() {
  if (_operations.isEmpty) {
    return '';
  }

  List<String> numbersAndOperators = _getDisplayTextAsNumbersAndOperators();

  double result = double.parse(numbersAndOperators[0]);

  for (int i = 1; i < numbersAndOperators.length - 1; i += 2) {
    String operator = numbersAndOperators[i];
    double nextNumber = double.parse(numbersAndOperators[i + 1]);

    switch (operator) {
      case '+':
        result += nextNumber;
        break;
      case '-':
        result -= nextNumber;
        break;
      case 'x':
        result *= nextNumber;
        break;
      case '/':
        result /= nextNumber;
        break;
    }
  }

  return result.toString();
}

List<String> _getDisplayTextAsNumbersAndOperators() {
  List<String> numbersAndOperators = [];
  String currentNumber = '';

  for (int i = 0; i < _displayText.length; i++) {
    if (_displayText[i] == '+' || _displayText[i] == '-' || _displayText[i] == 'x' || _displayText[i] == '/') {
      if (currentNumber.isNotEmpty) {
        numbersAndOperators.add(currentNumber);
        currentNumber = '';
      }
      numbersAndOperators.add(_displayText[i]);
    } else {
      currentNumber += _displayText[i];
    }
  }

  if (currentNumber.isNotEmpty) {
    numbersAndOperators.add(currentNumber);
  }

  return numbersAndOperators;
}


}
