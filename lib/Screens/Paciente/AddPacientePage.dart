import 'package:clinicachain/Screens/Widgets/BtnCustom.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AddPacientePage extends StatefulWidget
{
  @override
  _AddPacientePageState createState() => _AddPacientePageState();
}

class _AddPacientePageState extends State<AddPacientePage> {

  int selectedRadio = 1;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Agregar Familiar', style: GoogleFonts.getFont('Roboto', letterSpacing: 1, color: Color(0xff2B57C0), fontWeight: FontWeight.w600)),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black87, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Todos los campos son requeridos*', style: GoogleFonts.getFont('Roboto', color: Colors.grey[600])),
              SizedBox(height: 10),
              
              TextFieldCustom(hint: 'nombre', type: TextInputType.text, ),
              SizedBox(height: 15),
              TextFieldCustom(hint: 'Apellidos', type: TextInputType.text, ),
              SizedBox(height: 15),
              TextFieldCustom(hint: 'DNI', type: TextInputType.number, ),
              SizedBox(height: 15),
              _radioSexo(),
              SizedBox(height: 15),
              TextFieldCustom(hint: 'Domicilio', type: TextInputType.text, ),
              SizedBox(height: 15),
              TextFieldCustom(hint: 'Ocupacion', type: TextInputType.text, ),
              SizedBox(height: 15),
              TextFieldCustom(hint: 'Lugar de nacimiento', type: TextInputType.text, ),
              SizedBox(height: 15),
              TextFieldCustom(hint: 'Fecha de nacimiento', type: TextInputType.text, ),
              SizedBox(height: 15),
              TextFieldCustom(hint: 'Estado civil', type: TextInputType.text, ),
              SizedBox(height: 15),
              TextFieldCustom(hint: 'Grupo Sanguineo', type: TextInputType.text, ),
              SizedBox(height: 15),
              TextFieldCustom(hint: 'Parentesco', type: TextInputType.text, ),
              SizedBox(height: 15),
              TextFieldCustom(hint: 'Correo Electronico', type: TextInputType.emailAddress, ),
              SizedBox(height: 15),
              TextFieldCustom(hint: 'Contraseña', type: TextInputType.text, ),
              SizedBox(height: 20),
              BtnCustom(text: 'Registrar Familiar', borderRadius: 25,),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
     );
  }

  Widget _radioSexo(){
    return Container(
      color: Color(0xffEFF3F6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Radio(
                value: 1,
                groupValue: selectedRadio,
                activeColor: Color(0xff2B57C0),
                onChanged: (value) => setState(() => selectedRadio = value ),
              ),
              Text('Masculino', style: GoogleFonts.getFont('Roboto', fontSize: 17)),
            ],
          ),
          Row(
            children: [
              Radio(
                value: 0,
                groupValue: selectedRadio,
                activeColor: Color(0xff2B57C0),
                onChanged: (value) => setState(() => selectedRadio = value ),
              ),
              Text('Femenino', style: GoogleFonts.getFont('Roboto', fontSize: 17)),
            ],
          ),
        ],
      ),
    );
  }
}

class TextFieldCustom extends StatelessWidget {
  
  final TextInputType type;
  final String hint;
  final TextEditingController controller;

  const TextFieldCustom({this.type, this.hint, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: GoogleFonts.getFont('Roboto', fontSize: 18),
      keyboardType: type,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.getFont('Inter', color: Color(0xff2B57C0).withOpacity(0.4)),
        filled: true,
        fillColor: Color(0xffEFF3F6),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
    );
  }
}