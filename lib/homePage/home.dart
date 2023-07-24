import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nfc_2/templateFunctions/templateFunctions.dart';
import 'package:nfc_2/customFunctions/customFunctions.dart';
import 'package:nfc_manager/nfc_manager.dart';

import '../nfcmanager/view/app.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

ValueNotifier<dynamic> result = ValueNotifier(null);

class _HomePageState extends State<HomePage> {

  bool tagFound = false;
  bool apasatButonDeCitire = false;
  String citireArtbyte = 'Citire Tag ArtByte';
  String apropieTag = 'Apropie tag-ul';

  void _tagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      result.value = tag.data;
      NfcManager.instance.stopSession();
      tagFound = !tagFound;
      setState(() {

      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#009bb0"),
          title: const Text("NFC APP"),
          centerTitle: true,
        ), //bara de sus
        body: !tagFound ? Center(
          child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: HexColor("#009bb0"),
              ),
              onPressed: () {
                apasatButonDeCitire = true;
                _tagRead();
                setState(() {

                });
              },
              child:  Text(apasatButonDeCitire ? apropieTag:citireArtbyte)),
        )  :
        Center(
          child:  Wrap(
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
                        builder: (context) => Home(),
                      ),
                    );
                  },
                  child: const Text('Go to menu')),
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

              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: HexColor("#009bb0")),
                  onPressed: () {
                    tagFound = !tagFound;
                    setState(() {

                    });
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.arrow_back),
                      Text('Citire alt tag'),
                    ],
                  )),

            ],
          ),
        )
    );
  }
}