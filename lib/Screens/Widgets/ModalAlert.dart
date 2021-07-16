import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


void loadingDialog(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Color(0xff1A60C1),
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("CLINICA CHAIN", style: GoogleFonts.getFont('Roboto', fontSize: 19, color: Color(0xff1A60C1) , fontWeight: FontWeight.bold)),
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text('Verificando su información', style: GoogleFonts.getFont('Roboto', fontSize: 15)),
            ],
          ),
        );
      }
    );
  }