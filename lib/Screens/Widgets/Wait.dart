import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class WaitMoment extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 15.0),
          Text('Espere un momento...', style: GoogleFonts.getFont('Roboto', fontSize: 17)),
          SizedBox(height: 25.0),
        ],
      ),
    );
  }
}