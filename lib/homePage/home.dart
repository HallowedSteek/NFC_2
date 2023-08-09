import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nfc_2/customFunctions/customFunctions.dart';
import 'package:nfc_2/nfcmanager/view/edit_uri.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:http/http.dart' as http;

import '../nfcmanager/view/ndef_write.dart';
import '../nfcmanager/view/ndef_write_templates.dart';
import '../nfcmanager/view/tag_read.dart';

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
  String identifier = '';

Future<String> verifyTag(String identifier) async {
  var url = Uri.parse("https://nfc-backend-dsyy.onrender.com/checkNfc");

  var response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'nfcId': identifier,
    }),
  );

  if (response.statusCode == 200) {
    return response.body;
  } else {
    return "ERROARE";
  }

}

  Future<void> addNewTag(String identifier) async {
    var url = Uri.parse("https://nfc-backend-dsyy.onrender.com/addNfc");

    // Await the http get response, then decode the json-formatted response.
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nfcId': identifier,
      }),
    );

    if (response.statusCode == 200) {
      print("adaugat cu succes");
    } else {
      print("greseala");
    }

  }

  Future<void> _tagRead() async {

    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      result.value = tag.data;
      identifier = tag.data['ndef']['identifier'].toString();
      NfcManager.instance.stopSession();
      String raspuns = await verifyTag(identifier);
      raspuns == 'true' ? tagFound=!tagFound : tagFound=tagFound;
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
        body: false ? Center(
          child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: HexColor("#009bb0"),
              ),
              onPressed: () async {
                apasatButonDeCitire = true;
                await _tagRead();
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
                onPressed: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>  TagReadPage.withDependency(),
                )),
                child: const Text('Read Tag'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: HexColor("#009bb0"),
                ),
                onPressed: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => EditUriPage.withDependency(),
                )),
                child: const Text('Template Functions'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: HexColor("#009bb0"),
                ),
                onPressed: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => NdefWritePage.withDependency(),
                )),
                child: const Text('Custom Functions'),
              ),

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
                  child: const Text('Custom Functions Old')),
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