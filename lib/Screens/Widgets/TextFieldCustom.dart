import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class TextFieldCustomChain extends StatelessWidget
{
  final TextInputType type;
  final String hint;
  final TextEditingController controller;
  final int maxLines;
  final bool readOnly;
  final Color fillColor;
  final bool obscureText;
  final Function validator;

  const TextFieldCustomChain({
    this.type,
    this.hint, 
    this.controller, 
    this.maxLines = 1, 
    this.readOnly = false, 
    this.fillColor = const Color(0xffEFF3F6),
    this.obscureText = false,
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      readOnly: readOnly,
      controller: controller,
      cursorHeight: 21,
      style: GoogleFonts.getFont('Roboto', fontSize: 18),
      keyboardType: type,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.getFont('Inter', color: Color(0xff2B57C0).withOpacity(0.4)),
        filled: true,
        fillColor: fillColor,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
      validator: validator,
    );
  }

}