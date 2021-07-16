import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class BtnCustom extends StatelessWidget
{

  final String text;
  final Color colorOne;
  final Color colorTwo;
  final Function onPressed;
  final double height;
  final double borderRadius;

  const BtnCustom({ 
    @required this.text,
    this.height = 58,
    this.borderRadius = 8.0,
    this.colorOne = const Color(0xff1A60C1),
    this.colorTwo = const Color(0xff37C08C),
    this.onPressed 
  });

  @override
  Widget build(BuildContext context)
  {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            colorOne,
            colorTwo
          ]
        )
      ),
      child: TextButton(
        child: Text(this.text, style: GoogleFonts.getFont('Inter', fontSize: 23, color: Colors.white, fontWeight: FontWeight.w600)),
        onPressed: onPressed
      ),
    );
  }
}