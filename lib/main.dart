import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'gay calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "⌫") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        expression = equation;
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('×', '*');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
        onPressed: () => buttonPressed(buttonText),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(
                color: Colors.white, width: 1, style: BorderStyle.solid)),
        padding: EdgeInsets.all(16.0),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gay Calculator')),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("C", 1, Colors.redAccent),
                      buildButton("⌫", 1, Color(0xFF81E3E1)),
                      buildButton("÷", 1, Color(0xFFFF8C87)),
                    ]),
                    TableRow(children: [
                      buildButton("7", 1, Color(0xFFB3E561)),
                      buildButton("8", 1, Color(0xFFFFDC74)),
                      buildButton("9", 1, Color(0xFFFF6698)),
                    ]),
                    TableRow(children: [
                      buildButton("4", 1, Color(0xFFCE97FB)),
                      buildButton("5", 1, Color(0xFF129034)),
                      buildButton("6", 1, Color(0xFFFF7F00)),
                    ]),
                    TableRow(children: [
                      buildButton("1", 1, Color(0xFFE7E9EE)),
                      buildButton("2", 1, Color(0xFF426CA6)),
                      buildButton("3", 1, Color(0xFF9D7ADD)),
                    ]),
                    TableRow(children: [
                      buildButton(".", 1, Color(0xFFFFB76F)),
                      buildButton("0", 1, Color(0xFFA93D48)),
                      buildButton("00", 1, Color(0xFF050042)),
                    ]),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("×", 1, Color(0xFF53296A)),
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, Color(0xFF1E3569)),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, Color(0xFF4F6852)),
                    ]),
                    TableRow(children: [
                      buildButton("=", 2, Color(0xFFC50F3C)),
                    ]),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
