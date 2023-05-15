import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nfc_2/customFunctions/customFunctions.dart';
import 'package:nfc_2/templateFunctions/templateFunctions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

ValueNotifier<dynamic> result = ValueNotifier(null);

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#009bb0"),
          title: const Text("NFC APP"),
          centerTitle: true,
        ), //bara de sus
        body: Center(
          child: Wrap(
            spacing: 20, // to apply margin in the main axis of the wrap
            runSpacing: 20, // to apply margin in the cross axis of the wrap
            direction: Axis.vertical,
            children: [
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                    backgroundColor: HexColor("#009bb0"),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TemplateFunctions(),
                      ),
                    );
                  },
                  child: const Text('Template Functions')),
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: HexColor("#009bb0")),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CustomFunctions(),
                      ),
                    );
                  },
                  child: const Text('Custom Functions')),

            ],
          ),
        )
    );
  }
}
