import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nfc_2/data/database.dart';

var buttonStyle = TextButton.styleFrom(
  foregroundColor: Colors.black,
  backgroundColor:HexColor("#009bb0"),
);

var buttonStyleAddRemove = TextButton.styleFrom(
    foregroundColor: Colors.black,
    backgroundColor:HexColor("#009bb0"),
    fixedSize: const Size(100, 80)
);



class CustomFunctions extends StatefulWidget {
  const CustomFunctions({Key? key}) : super(key: key);

  @override
  State<CustomFunctions> createState() => _CustomFunctionsState();
}

class _CustomFunctionsState extends State<CustomFunctions> {
  CustomFunctionsData db= CustomFunctionsData();
  String text  = '';
  String numeFunctie = '';
  //reference data from box
  final _myBox = Hive.box("customFunctions");
  @override
  void initState() {

    //prima deschidere a aplicatiei
    if (_myBox.get('functiCustom')==null){
      db.createInitialData();
    } else {
      //incarca data deja existenta
      db.loadData();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#009bb0"),
        title: const Text("NFC APP - Custom Functions"),
        centerTitle: true,
      ), //bara de sus,
      body: Center(
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.65 ,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(left: 50, right: 50),

                  itemCount: db.data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: HexColor("#009bb0"),
                      child: ListTile(
                        title: db.data[index],
                        trailing: Container(
                          width: 100,
                          child: Row(
                            children: [
                              Expanded(
                                  child: IconButton(
                                      onPressed: () {
                                        showDialog(context: context, builder: (context) => SimpleDialog(
                                          children: [
                                            TextField(
                                              onChanged: (value){
                                                setState((){
                                                   text = value;
                                                });
                                              },
                                            ),
                                            FloatingActionButton(
                                              onPressed: (){
                                                  setState(() {
                                                        var newButton = TextButton(style: buttonStyle, onPressed: () {}, child:Text(text));
                                                        db.data[index] = newButton;
                                                        Navigator.pop(context);
                                                  });
                                            },
                                            shape: const StadiumBorder(),
                                            child: const Text("UPDATE")
                                            )
                                          ],
                                        ));
                                      }, icon: const Icon(Icons.edit))),
                              Expanded(
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          db.data.removeAt(index);
                                        });
                                      }, icon: const Icon(Icons.delete)))
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 50, bottom: 50),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        style:buttonStyleAddRemove,
                        onPressed: () {
                          showDialog(context: context, builder: (context) => SimpleDialog(
                            children: [
                              const Text("Nume Functie"),
                              TextField(
                                onChanged: (value){
                                  setState((){
                                    numeFunctie = value;
                                  });
                                },
                              ),
                              FloatingActionButton(
                                  onPressed: (){
                                    setState(() {
                                      var newButton = TextButton(style: buttonStyle, onPressed: () {}, child:Text(numeFunctie));
                                      db.data.add(newButton);
                                      Navigator.pop(context);
                                    });
                                  },
                                  shape: const StadiumBorder(),
                                  child: const Text("Add")
                              )
                            ],
                          ));
                        },
                        child:const Text("Add")
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
