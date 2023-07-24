import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nfc_2/templateFunctions/templateFunctions.dart';
import 'package:provider/provider.dart';
import 'homePage/home.dart';
import 'nfcmanager/repository/repository.dart';
import 'nfcmanager/view/app.dart';

void main() async{
  await Hive.initFlutter();

  var box = Hive.openBox("myBox");

  runApp(await withDependency());
}

Future<Widget> withDependency() async {
  final repo = await Repository.createInstance();
  return MultiProvider(
    providers: [
      Provider<Repository>.value(
        value: repo,
      ),
    ],
    child: const NfcApp(),
  );
}

class NfcApp extends StatelessWidget {
  const NfcApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      );
  }
}
