import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nfc_2/nfcmanager/view/tag_read.dart';
import 'package:provider/provider.dart';
import '../../customFunctions.dart';
import '../repository/repository.dart';
import 'common/form_row.dart';
import 'ndef_format.dart';
import 'ndef_write.dart';
import 'ndef_write_lock.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meniu'),
      ),
      body: ListView(
        padding: EdgeInsets.all(2),
        children: [
          FormSection(children: [
            FormRow(
              title: Text('Tag - Read'),
              trailing: Icon(Icons.chevron_right),
              onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => TagReadPage.withDependency(),
              )),
            ),
            FormRow(
              title: Text('Ndef - Write'),
              trailing: Icon(Icons.chevron_right),
              onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => NdefWritePage.withDependency(),
              )),
            ),
            FormRow(
              title: Text('Ndef - Write Lock'),
              trailing: Icon(Icons.chevron_right),
              onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => NdefWriteLockPage.withDependency(),
              )),
            ),
            if (Platform.isAndroid)
              FormRow(
                title: Text('Ndef - Format'),
                trailing: Icon(Icons.chevron_right),
                onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => NdefFormatPage.withDependency(),
                )),
              ),
            FormRow(
              title: Text('Ndef - Custom'),
              trailing: Icon(Icons.chevron_right),
              onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => const CustomFunctions()),),
            ),

          ]),
        ],
      ),
    );
  }
}

ThemeData _themeData(Brightness brightness) {
  return ThemeData(
    brightness: brightness,
     // Matches app icon color.
    primarySwatch:  MaterialColor(0xFF4D8CFE, <int, Color>{
      50: Color(0xFFEAF1FF),
      100: Color(0xFFCADDFF),
      200: Color(0xFFA6C6FF),
      300: Color(0xFF82AFFE),
      400: Color(0xFF689DFE),
      500: Color(0xFF4D8CFE),
      600: Color(0xFF4684FE),
      700: Color(0xFF3D79FE),
      800: Color(0xFF346FFE),
      900: Color(0xFF255CFD),
    }),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      errorStyle: TextStyle(height: 0.75),
      helperStyle: TextStyle(height: 0.75),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
      minimumSize: Size.fromHeight(40),
    )),
    scaffoldBackgroundColor: brightness == Brightness.dark
      ? Colors.black
      : null,
    cardColor: brightness == Brightness.dark
      ? Color.fromARGB(255, 28, 28, 30)
      : null,
    dialogTheme: DialogTheme(
      backgroundColor: brightness == Brightness.dark
        ? Color.fromARGB(255, 28, 28, 30)
        : null,
    ),
    highlightColor: brightness == Brightness.dark
      ? Color.fromARGB(255, 44, 44, 46)
      : null,
    splashFactory: NoSplash.splashFactory,
  );
}
