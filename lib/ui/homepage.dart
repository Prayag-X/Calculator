import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String value = "";
  double operand = 0;
  double answer = 0;
  String operatorSelected = "";
  bool onceAnswerGenerated = false;

  void setForNumber(int i) {
    if(onceAnswerGenerated){
      setState(() {
        value = i.toString();
        operand = i.toDouble();
        onceAnswerGenerated = false;
      });
    } else {
      setState(() {
        value += i.toString();
        operand = operand * 10 + i;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double calculatorAreaHeight = MediaQuery.of(context).size.width * 1.7;
    return Scaffold(
      backgroundColor: Color(0xFF151515),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
                child: Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                  ),
                ),
              ),
            ),
            Container(
              color: Color(0xFF1C1C1C),
              height: calculatorAreaHeight,
              width: MediaQuery.of(context).size.width,
              child: GridView(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                children: [
                  ...List.generate(
                    9,
                    (i) => CustomCalculatorButton(
                      value: (i + 1).toString(),
                      onTap: () {
                        setForNumber(i + 1);
                      },
                    ),
                  ),
                  CustomCalculatorButton(
                    value: 0.toString(),
                    onTap: () {
                      setForNumber(0);
                    },
                  ),
                  CustomCalculatorButton(
                    value: "=",
                    onTap: () {
                      setState(() {
                        switch (operatorSelected) {
                          case "+":
                            answer += operand;
                            break;
                          case "-":
                            answer -= operand;
                            break;
                          case "x":
                            answer *= operand;
                            break;
                          case "/":
                            answer /= operand;
                            break;
                          default:
                            break;
                        }
                        onceAnswerGenerated = true;
                        operatorSelected = "";
                        value = answer.toString();
                      });
                    },
                  ),
                  CustomCalculatorButton(
                    value: "+",
                    onTap: () {
                      if(operatorSelected != "") return;
                      setState(() {
                        value += " + ";
                        answer = operand;
                        operand = 0;
                        operatorSelected = "+";
                      });
                    },
                  ),
                  CustomCalculatorButton(
                    value: "-",
                    onTap: () {
                      if(operatorSelected != "") return;
                      setState(() {
                        value += " - ";
                        answer = operand;
                        operand = 0;
                        operatorSelected = "-";
                      });
                    },
                  ),
                  CustomCalculatorButton(
                    value: "X",
                    onTap: () {
                      if(operatorSelected != "") return;
                      setState(() {
                        value += " x ";
                        answer = operand;
                        operand = 0;
                        operatorSelected = "x";
                      });
                    },
                  ),
                  CustomCalculatorButton(
                    value: "/",
                    onTap: () {
                      if(operatorSelected != "") return;
                      setState(() {
                        value += " / ";
                        answer = operand;
                        operand = 0;
                        operatorSelected = "/";
                      });
                    },
                  ),

                  CustomCalculatorButton(
                    value: "C",
                    onTap: () {
                      setState(() {
                        value = "";
                        operand = 0;
                        answer = 0;
                        operatorSelected = "";
                        onceAnswerGenerated = false;
                      });
                    },
                  ),
                  CustomCalculatorButton(
                    value: "<-",
                    onTap: () {
                      print(operand);
                      if(operatorSelected != "" && operand == 0) {
                        setState(() {
                          value  = value.substring(0, value.length - 3);
                          operatorSelected = "";
                          operand = answer;
                        });
                      } else {
                        setState(() {
                          print(operand);
                          value  = value.substring(0, value.length - 1);
                          operand = (operand - (operand % 10)) / 10;
                          print(operand);
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Gesture Detector
// TextButton

class CustomCalculatorButton extends StatelessWidget {
  const CustomCalculatorButton(
      {super.key, required this.value, required this.onTap});
  final String value;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Center(
        child: Text(
          value,
          style: TextStyle(
            color: Color(0xff446da8),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// 193
// (193 - 3) / 10

// 193 % 10 = 3

// 19
// (19 * 10) + 3