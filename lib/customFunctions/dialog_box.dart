import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nfc_2/customFunctions/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
   DialogBox({super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: HexColor("#00ADC4"),
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
           TextField(
             controller: controller,
            decoration: InputDecoration(
                border:OutlineInputBorder(),
                hintText:  "Adauga functie noua.",
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //save button
              MyButton(text: "Save", onPressed:onSave),
              const SizedBox(width: 6),
              //cancel button
              MyButton(text: "Cancel", onPressed:onCancel),
            ],
          )
        ]
        ),
      ),

    );
  }
}
