import 'package:clinicachain/Screens/Widgets/TextChain.dart';
import 'package:flutter/material.dart';


void modalLoading(BuildContext context, String message){
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.white70,
      builder: (BuildContext context){
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          content: Container(
            height: 90,
            width: MediaQuery.of(context).size.width * .95,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextChain(text: "CLINICA CHAIN", fontSize: 25, color: Colors.blue , fontWeight: FontWeight.bold),
                SizedBox(height: 15),
                Row(
                  children: [
                    CircularProgressIndicator(backgroundColor: Colors.green, color: Colors.blue, strokeWidth: 5 ),
                    SizedBox(width: 20),
                    TextChain(text:  message, fontSize: 20, color: Colors.black),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    );
  }