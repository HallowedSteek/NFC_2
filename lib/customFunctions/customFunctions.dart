import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nfc_2/customFunctions/dialog_box.dart';
import 'package:nfc_2/data/customDataBase.dart';

import 'numeFunctii.dart';




class CustomFunctions extends StatefulWidget {
  const CustomFunctions({Key? key}) : super(key: key);

  @override
  State<CustomFunctions> createState() => _CustomFunctionsState();
}

class _CustomFunctionsState extends State<CustomFunctions> {
  //reference box
  final _myBox = Hive.box("myBox");
  CustomDataBase db = CustomDataBase();

  @override
  void initState() {
    //prima deschidere a aplicatiei creaza data dfefault
    if(_myBox.get("Functii")==null){
      db.createInitialData();
    }else{
      //deja exista data
      db.loadData();
    }
    super.initState();
  }
  //text controller
  final _controller=TextEditingController();


  //save new function
  void saveNewFunction(){
    setState(() {
      db.butoaneSalvate.add([_controller.text]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  //create new button
  void createNewButton(){
      showDialog(
          context: context,
          builder: (context){
        return DialogBox(
          controller:_controller ,
          onSave: saveNewFunction,
          onCancel:Navigator.of(context).pop,
        );
      }
          );
  }

  //delete button
  void deleteButton(int index){
      setState(() {
        db.butoaneSalvate.removeAt(index);
      });
      db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: HexColor("#00ADC4"),
        title: Text('Custom Functions'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: HexColor("#00ADC4"),
        onPressed: createNewButton,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: db.butoaneSalvate.length,
          itemBuilder: (contex, index){
            return Functii(
                numeFunctie: db.butoaneSalvate[index][0],
                deleteFunction: (context) => deleteButton(index) ,

            );
          }
      )
    );
  }
}
