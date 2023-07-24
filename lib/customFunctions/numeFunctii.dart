import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hexcolor/hexcolor.dart';


class Functii extends StatelessWidget {
  final String numeFunctie;
  Function(BuildContext)? deleteFunction;

  Functii({super.key,
    required this.numeFunctie,
    required this.deleteFunction
  });

  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
                onPressed: deleteFunction,
                icon: Icons.delete,
              backgroundColor: Colors.red,
            )
          ],
        ),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20.0),
          child:
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: HexColor("#009bb0"),
              foregroundColor: Colors.black,
            ),
            child: Text(numeFunctie,style: const TextStyle(fontSize: 15),),
            onPressed: () {},

          ),
        ),
      ),
    );
  }
}
