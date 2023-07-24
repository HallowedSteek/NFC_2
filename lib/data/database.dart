import 'package:hive_flutter/hive_flutter.dart';

class CustomFunctionsData {
  List data = [];
  //box
  final _myBox=Hive.box("customFunctions");

  //prima deschidere
  void createInitialData(){
    data=[];
  }
  //load data
  void loadData(){
    data=_myBox.get('functiCustom');
  }
  //update db
  void updateDataBase(){
    _myBox.put('functiiCustom', data);
  }
}