import 'package:flutter/material.dart';

class resultPage extends StatelessWidget {
  const resultPage(
      {required this.counter,
      required this.inputNumber,
      required this.function});
  final int counter;
  final int inputNumber;
  final String function;
  @override
  Widget build(BuildContext context) {
    int result = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '\t\t\t\t\t\t$inputNumber',
              style: TextStyle(fontSize: 50),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$function\t\t\t\t\t\t',
                  style: TextStyle(fontSize: 50),
                ),
                Text(
                  '$counter',
                  style: TextStyle(fontSize: 50),
                ),
              ],
            ),
            Text(
              '_________',
              style: TextStyle(fontSize: 50),
            ),
            if (function == "x")
              Text(
                '${counter == 0 || inputNumber == 0 ? 0 : inputNumber * counter}',
                style: TextStyle(fontSize: 50),
              )
            else
              Text(
                '${counter == 0 || inputNumber == 0 ? 0 : inputNumber / counter}',
                style: TextStyle(fontSize: 50),
              )
          ],
        ),
      ),
    );
  }
}
