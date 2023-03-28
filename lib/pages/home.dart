import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    
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
              height: height * 0.15,
              alignment: Alignment.topRight,
              padding: EdgeInsets.only(right: width*0.05),
              child: Text(
                orientation == Orientation.portrait ? 'Portrait' : 'Landscape',
                style: const TextStyle(fontSize: 32),
              ),
            ),
            createRow(items: ['C', '( )', '%', '÷'], width: width),
            createRow(items: ['7', '8', '9', '×'], width: width),
            createRow(items: ['4', '5', '6', '-'], width: width),
            createRow(items: ['1', '2', '3', '+'], width: width),
            createRow(items: ['±', '0', '.', '='], width: width),
          ],
        ),
      ),
    );
  }

  void buttonClick(String action) {
    switch (action) {
      // TODO commands
      default:
        break;
    }
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