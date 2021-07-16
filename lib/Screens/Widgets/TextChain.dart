import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class TextChain extends StatelessWidget
{
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final double letterSpacing;
  final String text;

  const TextChain({
    @required this.text,
    this.fontSize = 18, 
    this.fontWeight = FontWeight.normal, 
    this.color = Colors.black87, 
    this.letterSpacing = 0
  });

  @override
  Widget build(BuildContext context)
  {
    return Text(
      text,
      style: GoogleFonts.getFont('Roboto', fontSize: fontSize, color: color, fontWeight: fontWeight, letterSpacing: letterSpacing),
    );
  }
}