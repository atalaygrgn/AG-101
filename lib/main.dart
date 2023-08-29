import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "AG-101",
      theme: ThemeData(primarySwatch: Colors.grey, fontFamily: "Casio"),
      home: const SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({super.key});

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
      } else if (buttonText == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        expression = equation;
        expression = expression.replaceAll("×", "*");

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = "${exp.evaluate(EvaluationType.REAL, cm)}";
        } catch (e) {
          result = "ERROR";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation += buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor,
      {double buttonWidth = 1}) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      width: MediaQuery.of(context).size.width * 0.25 * buttonWidth,
      color: buttonColor,
      child: TextButton(
          onPressed: () => buttonPressed(buttonText),
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0))),
          child: Text(
            buttonText,
            style: const TextStyle(
                fontFamily: "Roboto",
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "CASIO",
          style: TextStyle(fontFamily: "Eurostile"),
        ),
        actions: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Container(
              width: 120,
              height: 20,
              color: Colors.white70,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 28,
                      color: const Color.fromARGB(200, 127, 78, 41),
                    ),
                    Container(
                      width: 28,
                      color: const Color.fromARGB(200, 127, 78, 41),
                    ),
                    Container(
                      width: 28,
                      color: const Color.fromARGB(200, 127, 78, 41),
                    ),
                    Container(
                      width: 28,
                      color: const Color.fromARGB(200, 127, 78, 41),
                    ),
                  ]),
            ),
          )
        ],
        centerTitle: false,
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.grey[900],
        child: SafeArea(
          child: Container(
            color: Colors.black,
            child: Column(children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(108, 123, 97, 1),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                        child: Text(
                          equation,
                          style: const TextStyle(
                              fontSize: 20.0, color: Colors.black87),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                        child: Text(
                          result,
                          style: const TextStyle(
                              fontSize: 28.0, color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                color: Colors.grey[900],
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 24.0, right: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "AG-101",
                          style: TextStyle(
                              fontFamily: "Eurostile",
                              color: Colors.white,
                              fontSize: 20),
                        ),
                        Text(
                          "solar-powered",
                          style: TextStyle(
                              fontFamily: "Eurostile",
                              color: Colors.white,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: Table(
                          children: [
                            TableRow(children: [
                              buildButton("C", 1, Colors.blueAccent),
                              buildButton("+", 1, Colors.lime),
                              buildButton("-", 1, Colors.lime),
                            ]),
                            TableRow(children: [
                              buildButton("7", 1, Colors.grey),
                              buildButton("8", 1, Colors.grey),
                              buildButton("9", 1, Colors.grey),
                            ]),
                            TableRow(children: [
                              buildButton("4", 1, Colors.grey),
                              buildButton("5", 1, Colors.grey),
                              buildButton("6", 1, Colors.grey),
                            ]),
                            TableRow(children: [
                              buildButton("1", 1, Colors.grey),
                              buildButton("2", 1, Colors.grey),
                              buildButton("3", 1, Colors.grey),
                            ]),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: Row(children: [
                          buildButton(".", 1, Colors.grey),
                          buildButton("0", 1, Colors.grey, buttonWidth: 2),
                        ]),
                      )
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Table(
                      children: [
                        TableRow(children: [
                          buildButton("×", 1, Colors.lime),
                        ]),
                        TableRow(children: [
                          buildButton("/", 1, Colors.lime),
                        ]),
                        TableRow(children: [
                          buildButton("⌫", 1, Colors.redAccent),
                        ]),
                        TableRow(children: [
                          buildButton("=", 2, Colors.blueAccent),
                        ]),
                      ],
                    ),
                  )
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
