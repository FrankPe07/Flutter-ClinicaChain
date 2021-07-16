import 'package:clinicachain/Bloc/Auth/auth_bloc.dart';
import 'package:clinicachain/Bloc/Medico/medico_bloc.dart';
import 'package:clinicachain/Helpers/Drawer.dart';
import 'package:clinicachain/Helpers/DrawerAdmin.dart';
import 'package:clinicachain/Screens/Widgets/BtnCustom.dart';
import 'package:clinicachain/Screens/Widgets/ModalLoading.dart';
import 'package:clinicachain/Screens/Widgets/ModalSuccess.dart';
import 'package:clinicachain/Screens/Widgets/TextChain.dart';
import 'package:clinicachain/Screens/Widgets/TextFieldCustom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


class AddMedicoPage extends StatefulWidget {
  @override
  _AddMedicoPageState createState() => _AddMedicoPageState();
}


class _AddMedicoPageState extends State<AddMedicoPage> {

  TextEditingController nombreCompletoController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController dniController = TextEditingController();
  TextEditingController cpmcontroller = TextEditingController();
  TextEditingController rneController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController direccionConsultaController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    final _scafolkey = new GlobalKey<ScaffoldState>();
    final authBloc = BlocProvider.of<AuthBloc>(context).state;
    final medicobloc = BlocProvider.of<MedicoBloc>(context);
    
    return BlocListener<MedicoBloc, MedicoState>(
      listener: (context, state) {
        if( state is LoadingMedicoState ){

          modalLoading(context, 'Agregar Medico a Wallet');

        } else if ( state is SuccessMedicoState ){

          Navigator.of(context).pop();
          clearCampos();
          modalSuccess(context, 'Medico registrado!');

        } else if ( state is FailureMedicoState ){

          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: TextChain(text: state.error ), backgroundColor: Colors.red ));
        }
      },
      child: Scaffold(
        key: _scafolkey,
        drawer: DrawerCustom().drawerCustom( authBloc.idrolStorage, context, '${authBloc.nombreStorage} ${authBloc.lastnameStorage}', authBloc.emailStorage, DrawerSeccions.addMedico),
        backgroundColor: Color(0xffF3F3F8),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Agregar Medicos', style: GoogleFonts.getFont('Roboto', letterSpacing: 1, color: Color(0xff2B57C0), fontWeight: FontWeight.w600)),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.sort, size: 29, color: Color(0xff2B57C0)),
            onPressed: () => _scafolkey.currentState.openDrawer()
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            TextChain(text: 'Nombre completo', fontSize: 17),
            TextFieldCustomChain(controller: nombreCompletoController, fillColor: Colors.white, maxLines: 1 ),
            SizedBox(height: 15.0),
            TextChain(text: 'Apellidos', fontSize: 17),
            TextFieldCustomChain(controller: apellidoController, fillColor: Colors.white, maxLines: 1 ),
            SizedBox(height: 15.0),
            TextChain(text: 'DNI', fontSize: 17),
            TextFieldCustomChain(controller: dniController, fillColor: Colors.white, maxLines: 1, type: TextInputType.number, hint: '12345678'),
            SizedBox(height: 15.0),
            Row(
              children: [
                Flexible(child: TextFieldCustomChain( hint: 'CPM', controller: cpmcontroller, fillColor: Colors.white, maxLines: 1 )),
                SizedBox(width: 15),
                Flexible(child: TextFieldCustomChain( hint: 'RNE', controller: rneController, fillColor: Colors.white, maxLines: 1 )),
              ],
            ),
            SizedBox(height: 15.0),
            TextChain(text: 'Descripcion', fontSize: 17),
            TextFieldCustomChain(controller: descripcionController, fillColor: Colors.white ),
            SizedBox(height: 15.0),
            TextChain(text: 'Direccion Consulta', fontSize: 17),
            TextFieldCustomChain(controller: direccionConsultaController, fillColor: Colors.white ),
            SizedBox(height: 15.0),
            TextChain(text: 'Correo Electronico', fontSize: 17),
            TextFieldCustomChain(controller: correoController, fillColor: Colors.white, maxLines: 1, type: TextInputType.emailAddress ),
            SizedBox(height: 15.0),
            TextChain(text: 'Contraseña', fontSize: 17),
            TextFieldCustomChain(controller: passwordController, fillColor: Colors.white, maxLines: 1 ),
            SizedBox(height: 25.0),
            BtnCustom(
              text: 'Guardar Medico', 
              borderRadius: 20,
              onPressed: (){
                
                medicobloc.add( AddMedicoBlockchainEvent(
                  nombre: nombreCompletoController.text,
                  apellidos: apellidoController.text,
                  dni: dniController.text,
                  cpm: cpmcontroller.text,
                  rne: rneController.text,
                  decripcion: descripcionController.text,
                  direccion: direccionConsultaController.text,
                  correo: correoController.text,
                  contrasena: passwordController.text
                ));
              },
            )
          ],
        ),
      ),
    );
  }

  void clearCampos(){
    nombreCompletoController.clear();
    apellidoController.clear();
    dniController.clear();
    cpmcontroller.clear();
    rneController.clear();
    descripcionController.clear();
    direccionConsultaController.clear();
    correoController.clear();
    passwordController.clear();
  }

}