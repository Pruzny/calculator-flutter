import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double? _result;
  String _operation = '';
  String _outputText = '';
  bool _blockOutput = false;
  bool _reset = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    TextEditingController textController = TextEditingController(text: _outputText);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculator',
          style: TextStyle(fontSize: 32),
        ),
        centerTitle: true,
      ),

      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: height * 0.2,
              alignment: Alignment.topRight,
              padding: EdgeInsets.only(right: width*0.05, left: width*0.05),
              child: TextFormField(
                keyboardType: TextInputType.none,
                autofocus: true,
                textAlign: TextAlign.end,
                maxLines: 1,
                controller: textController,
                decoration: const InputDecoration(
                  border: InputBorder.none
                ),
                style: TextStyle(
                  fontSize: width/10,
                ),
              ),
            ),
            createRow(items: ['C', ' 𝑥²', '%', '÷'], width: width),
            createRow(items: ['7', '8', '9', '×'], width: width),
            createRow(items: ['4', '5', '6', '-'], width: width),
            createRow(items: ['1', '2', '3', '+'], width: width),
            createRow(items: ['±', '0', '.', '='], width: width),
          ],
        ),
      ),
    );
  }

  double? calculate(double firstNumber, double secondNumber, String operation) {
    switch (operation) {
      case '+':
        return firstNumber + secondNumber;
      case '-':
        return firstNumber - secondNumber;
      case '×':
        return firstNumber * secondNumber;
      case '÷':
        return firstNumber / secondNumber;
      case ' 𝑥²':
        return firstNumber * firstNumber;
      case '%':
        return firstNumber / 100;
      default:
        _outputText = 'Internal Error';
        _blockOutput = true;
        return null;
    }
  }

  void showResult() {
    _outputText = '${_result == _result!.roundToDouble() ? _result!.round() : _result}';
    setState(() {});
  }

  void buttonClick(String button) {
    if (!_blockOutput) {
      double? buttonNumber = double.tryParse(button);
      if (buttonNumber != null) {
        if (_reset) {
          _outputText = '';
          _reset = false;
        }
        _outputText += button;
      } else {
        double? number = double.tryParse(_outputText);
        if (number != null) {
          if (operators.contains(button)) {
            _outputText = '';
            _result = _result != null && _operation != '' ? calculate(_result!, number, _operation) : number;
            _operation = button;
          } else if (directOperators.contains(button)) {
            _result = calculate(number, 0, button);
            _operation = button;
            showResult();
          } else if (button == '=' && _result != null) {
            _result = calculate(_result!, number, _operation);
            showResult();
            _reset = true;
          } else if (button == '.' && !_outputText.contains('.')) {
            _outputText += '.';
          } else if (button == '±' && _outputText != '') {
            _result = -number;
            showResult();
          }
        }
      }
    }

    if (button == 'C') {
      _historyText = '';
      _outputText = '';
      _blockOutput = false;
      _operation = '';
      _result = null;
    }
    
    setState(() {});
  }

  OutlinedButton createButton({required String text, required double width}) {
    return OutlinedButton(
      onPressed: () => buttonClick(text),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const CircleBorder()),
        fixedSize: MaterialStateProperty.all(Size(width, width)),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: width/2),
      ),
    );
  }

  Row createRow({required List<String> items, required double width}) {
    int total = items.length + 1;
    double size = width/total;
    List<OutlinedButton> buttons = [];
    for (String item in items) {
      buttons.add(createButton(text: item, width: size));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons,
    );
  }
}

Set<String> operators = {
  '+',
  '-',
  '×',
  '÷',
};

Set<String> directOperators = {
  ' 𝑥²',
  '%',
};