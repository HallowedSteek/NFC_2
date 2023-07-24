import 'package:hive/hive.dart';

  class CustomDataBase{
   List butoaneSalvate =[];
  //reference box
  final _myBox=Hive.box("myBox");
//prima deschidere a aplicatiei
  void createInitialData(){
    butoaneSalvate=[];
  }
  //load data
  void loadData(){
    butoaneSalvate =_myBox.get("Functii");

  }
  //update data
  void updateData(){
    _myBox.put("Functii",butoaneSalvate);
  }
}