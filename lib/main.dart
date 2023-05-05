import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'home.dart';

void main() async{
  await Hive.initFlutter();

  var box = Hive.openBox("customFunctions");

  runApp(const NfcApp());
}


class NfcApp extends StatelessWidget {
  const NfcApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      );

  }
}
