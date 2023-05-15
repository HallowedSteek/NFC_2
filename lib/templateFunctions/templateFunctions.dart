import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TemplateFunctions extends StatefulWidget {
  const TemplateFunctions({Key? key}) : super(key: key);

  @override
  State<TemplateFunctions> createState() => _TemplateFunctionsState();
}

var buttonStyle = TextButton.styleFrom(
    foregroundColor: Colors.black,
    backgroundColor: HexColor("#009bb0")
);

class _TemplateFunctionsState extends State<TemplateFunctions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#009bb0"),
        title: const Text("NFC APP - Template Functions"),
        centerTitle: true,
      ), //bara de sus,
      body: Center(
        child: Wrap(
          spacing: 20, // to apply margin in the main axis of the wrap
          runSpacing: 20, // to apply margin in the cross axis of the wrap
          direction: Axis.vertical,
          children: [
            TextButton(
                style: buttonStyle,
                onPressed:(){},
                child: Text("Template Func 1")),
            TextButton(
                style: buttonStyle,
                onPressed:(){},
                child: Text("Template Func 3")),
            TextButton(
                style: buttonStyle,
                onPressed:(){},
                child: Text("Template Func 4")),
            TextButton(
                style: buttonStyle,
                onPressed:(){},
                child: Text("Template Func 5")),
          ],
        ),

      ),
    );
  }
}
