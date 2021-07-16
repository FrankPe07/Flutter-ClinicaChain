import 'package:clinicachain/Controller/DBAmin.dart';
import 'package:clinicachain/Screens/Widgets/BtnCustom.dart';
import 'package:clinicachain/Screens/Widgets/TextFieldCustom.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AddEspecialidadPage extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    TextEditingController especialidadController = TextEditingController();
    TextEditingController descripcionController = TextEditingController();

    return Scaffold(
      backgroundColor: Color(0xffF3F3F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Agregar Especialidad', style: GoogleFonts.getFont('Roboto', letterSpacing: 1, color: Color(0xff2B57C0), fontWeight: FontWeight.w600)),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, size: 22, color: Color(0xff2B57C0)),
          onPressed: () => Navigator.pop(context)
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text('Nombre de especialidad', style: GoogleFonts.getFont('Roboto', fontSize: 17)),
            SizedBox(height: 5),
            TextFieldCustomChain(fillColor: Colors.white, controller: especialidadController,),
            SizedBox(height: 5),
            Text('Descripcion especialidadd', style: GoogleFonts.getFont('Roboto', fontSize: 17)),
            SizedBox(height: 5),
            TextFieldCustomChain(fillColor: Colors.white, maxLines: 4, controller: descripcionController,),
            
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: BtnCustom(text: 'Guardar Especialidad', borderRadius: 50, onPressed: () async {

                  final resp = await dbAdmin.addNuevaEspecialidadMedica(
                    especialidad: especialidadController.text.trim(),
                    descripcion: descripcionController.text.trim()
                  );

                  if(resp) Navigator.pop(context);
                  else Scaffold.of(context).showBottomSheet((context) => Text('Algo salio mal'));
                  
                })
              )
            )
          ],
        ),
      ),
     );
  }
}