import 'package:dart_eval/dart_eval.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var textfeildtext = "";
  var num = 0;
  var operation;
  var specialCmd;
  var result;

  late TextEditingController textFieldController;
  @override
  void initState() {
    super.initState();
    textFieldController = TextEditingController();
  }

  detach() {
    textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Calculator',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.blueAccent,
        ),
        body: Column(
          children: [
            TextField(
              controller: textFieldController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Result',
              ),
              scrollPadding: EdgeInsets.all(20),
            ),

            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              scrollDirection: Axis.vertical,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 20.0,
              padding: EdgeInsets.all(10),
              children: [
                SpecialButton("AC"),
                OperationButton("%"),
                SpecialButton("Back"),
                OperationButton("/"),
                NumButton("7"),
                NumButton("5"),
                NumButton("9"),
                OperationButton("*"),
                NumButton("4"),
                NumButton("5"),
                NumButton("6"),
                OperationButton("-"),
                NumButton("1"),
                NumButton("2"),
                NumButton("3"),
                OperationButton("+"),
                NumButton("00"),
                NumButton("0"),
                NumButton("."),
                ResultButton("="),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton NumButton(String text) {
    return ElevatedButton(
      style: ButtonStyle(shape: WidgetStatePropertyAll(CircleBorder())),
      onPressed: () {
        num = int.tryParse(text) ?? 0;
        // onPressedNum();
        textfeildtext = textfeildtext + text;
        textFieldController.text = textfeildtext;
      },
      child: Text(
        text,
        style: TextStyle(
          color: Colors.blue,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  ElevatedButton OperationButton(String text) {
    return ElevatedButton(
      style: ButtonStyle(shape: WidgetStatePropertyAll(CircleBorder())),
      onPressed: () {
        operation = text;
        textfeildtext = textfeildtext + text;
        textFieldController.text = textfeildtext;
        // onPressedOperation();
      },
      child: Text(
        text,
        style: TextStyle(
          color: Colors.green,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  ElevatedButton SpecialButton(String text) {
    return ElevatedButton(
      style: ButtonStyle(shape: WidgetStatePropertyAll(CircleBorder())),
      onPressed: () {
        specialCmd = text;
        onPressedSpecial();
      },
      child: Text(
        text,
        style: TextStyle(
          color: Colors.purple,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  ElevatedButton ResultButton(String text) {
    return ElevatedButton(
      style: ButtonStyle(shape: WidgetStatePropertyAll(CircleBorder())),
      onPressed: () {
        result = eval(textfeildtext);
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Calculation Done! ${result.toString()}'),
        //     duration: Duration(seconds: 1),
        //   ),
        // );
        calculateResult();
      },
      child: Text(
        text,
        style: TextStyle(
          color: Colors.red,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  void onPressedNum() {
    textFieldController.text = num.toString();
  }

  void onPressedOperation() {
    textFieldController.text = operation;
  }

  void onPressedSpecial() {
    if (specialCmd == "AC") {
      textFieldController.text = "";
      textfeildtext = "";
    }
    if (specialCmd == "Back") {
      if (textfeildtext.isNotEmpty) {
        textfeildtext = textfeildtext.substring(0, textfeildtext.length - 1);
        textFieldController.text = textfeildtext;
      }
    }
  }

  void calculateResult() {
    textFieldController.text = "";
    textfeildtext = "";
    textFieldController.text = result.toString();
  }
}
