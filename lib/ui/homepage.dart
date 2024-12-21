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

  @override
  Widget build(BuildContext context) {
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
              height: MediaQuery.of(context).size.width * 1.7,
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
                        setState(() {
                          value += (i + 1).toString();
                          operand = operand * 10 + (i + 1);
                        });
                      },
                    ),
                  ),
                  CustomCalculatorButton(
                    value: 0.toString(),
                    onTap: () {
                      setState(() {
                        value += 0.toString();
                        operand = operand * 10;
                      });
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
                        value = answer.toString();
                      });
                    },
                  ),
                  CustomCalculatorButton(
                    value: "+",
                    onTap: () {
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
                      setState(() {
                        value += " / ";
                        answer = operand;
                        operand = 0;
                        operatorSelected = "/";
                      });
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
