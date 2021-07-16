import 'package:clinicachain/Screens/Widgets/TextChain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void modalSuccess(BuildContext context, String message){
    showDialog(
      context: context,
      barrierColor: Colors.white70,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          content: Container(
            height: 175,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                TextChain(text: "CLINICA CHAIN", fontSize: 25, color: Colors.blue , fontWeight: FontWeight.bold),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.check_circle_outline_rounded, size: 60, color: Colors.green),
                    SizedBox(width: 15),
                    TextChain(text: message, fontSize: 20),
                  ],
                ),
                Divider(),
                Container(
                  color: Color(0xffF5F5F5),
                  height: 50,
                  width: double.infinity,
                  child: TextButton(
                    child: TextChain(text: 'Entendido', fontSize: 19 ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }