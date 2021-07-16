import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Load extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    return Container(
      color: Color(0XFF004481),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(backgroundColor: Colors.white ),
            SizedBox(height: 15),
            Text('Estamos verificando su información...', style: GoogleFonts.getFont('Roboto', color: Colors.white, fontSize: 17))
          ],
        )
      ),
    );
  }
}