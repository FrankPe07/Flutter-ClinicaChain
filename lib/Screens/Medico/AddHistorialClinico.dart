import 'package:clinicachain/Bloc/Auth/auth_bloc.dart';
import 'package:clinicachain/Bloc/HistorialClinico/historialclinico_bloc.dart';
import 'package:clinicachain/Screens/Medico/CitaPage.dart';
import 'package:clinicachain/Screens/Widgets/BtnCustom.dart';
import 'package:clinicachain/Screens/Widgets/ModalLoading.dart';
import 'package:clinicachain/Screens/Widgets/ModalSuccess.dart';
import 'package:clinicachain/Screens/Widgets/TextChain.dart';
import 'package:clinicachain/Screens/Widgets/TextFieldCustom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


class AddHistorialClinicoPage extends StatefulWidget
{
  @override
  _AddHistorialClinicoPageState createState() => _AddHistorialClinicoPageState();
}

class _AddHistorialClinicoPageState extends State<AddHistorialClinicoPage> 
{

  TextEditingController anamnesisController = TextEditingController();
  TextEditingController paController = TextEditingController();
  TextEditingController pulsoController = TextEditingController();
  TextEditingController temperaturaController = TextEditingController();
  TextEditingController fcController = TextEditingController();
  TextEditingController frController = TextEditingController();
  TextEditingController exmaneClinicoController = TextEditingController();
  TextEditingController diagnosticoController = TextEditingController();
  TextEditingController tratamientoController = TextEditingController();
  TextEditingController proximaCitaController = TextEditingController();

  @override
  void dispose() {
    anamnesisController.clear();
    paController.clear();
    pulsoController.clear();
    temperaturaController.clear();
    fcController.clear();
    frController.clear();
    exmaneClinicoController.clear();
    diagnosticoController.clear();
    tratamientoController.clear();
    proximaCitaController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    final historiaClinicaBloc = BlocProvider.of<HistorialclinicoBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Nueva Historia Clinica', style: GoogleFonts.getFont('Roboto', letterSpacing: 1, color: Color(0xff2B57C0), fontWeight: FontWeight.w600)),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, size: 22, color: Color(0xff2B57C0)),
          onPressed: () => Navigator.pop(context)
        ),
        actions: [
          Icon(Icons.help, color: Colors.grey[700], ),
          SizedBox(width: 5)
        ],
      ),
      body: BlocListener<HistorialclinicoBloc, HistorialclinicoState>(
        listener: (context, state) {
          if( state is LoadingHistorialState ){

            modalLoading(context, 'Agregando al bloque...');

          } else if ( state is SuccessHistorialState ){

            Navigator.of(context).pop();
            modalSuccess(context, 'Bloque creado');
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => CitasPage()));

          } else  if ( state is FailureHistorialState ){

            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar( SnackBar(
              content: TextChain(text: 'Su identidad no esta inscrita o carga', fontSize: 17, color: Colors.white ),
              backgroundColor: Colors.red,
            ));
          }
        },
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          children: [
              TextChain(text: 'Anamnesis', fontSize: 17),
              TextFieldCustomChain(controller: anamnesisController,),
              SizedBox(height: 15.0),
              TextChain(text: 'PA', fontSize: 17),
              TextFieldCustomChain( hint: 'PA', controller: paController,),
              SizedBox(height: 15.0),
              TextChain(text: 'Pulso', fontSize: 17),
              TextFieldCustomChain(controller: pulsoController,),
              SizedBox(height: 15.0),
              TextChain(text: 'Temperatura', fontSize: 17),
              TextFieldCustomChain(controller: temperaturaController,),
              SizedBox(height: 15.0),
              
              Row(
                children: [
                  Flexible(child: TextFieldCustomChain( hint: 'FC', controller: fcController,)),
                  SizedBox(width: 15),
                  Flexible(child: TextFieldCustomChain( hint: 'FR', controller: frController,)),
                ],
              ),
              SizedBox(height: 15.0),
              TextChain(text: 'Examen clinico', fontSize: 17),
              TextFieldCustomChain( maxLines: 3, controller: exmaneClinicoController,),
              SizedBox(height: 15.0),
              TextChain(text: 'Diagnostico', fontSize: 17),
              TextFieldCustomChain( maxLines: 2, controller: diagnosticoController,),
              SizedBox(height: 15.0),
              TextChain(text: 'Tratamiento', fontSize: 17),
              TextFieldCustomChain(maxLines: 3, controller: tratamientoController,),
              SizedBox(height: 15.0),
              TextChain(text: 'Proxima Cita', fontSize: 17),
              TextFieldCustomChain(controller: proximaCitaController,),
              SizedBox(height: 20.0),

              BtnCustom(text: 'Guardar datos', borderRadius: 50, onPressed: (){

                historiaClinicaBloc.add( SaveHistorialClinicoEvent(
                  fecha: DateTime.now().toString(),
                  anamnesis: anamnesisController.text,
                  pa: paController.text,
                  pulso: pulsoController.text,
                  temperatura: temperaturaController.text,
                  fc: fcController.text,
                  fr: frController.text,
                  examenClinico: exmaneClinicoController.text,
                  diagnostico: diagnosticoController.text,
                  tratamiento: tratamientoController.text,
                  proximaCita: proximaCitaController.text,
                  dni: authBloc.state.dni
                ));

                
              })
          ],
        )

      )
     );
  }
}