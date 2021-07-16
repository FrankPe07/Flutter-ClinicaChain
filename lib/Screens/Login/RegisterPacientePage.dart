import 'package:clinicachain/Bloc/Paciente/paciente_bloc.dart';
import 'package:clinicachain/Screens/Widgets/BtnCustom.dart';
import 'package:clinicachain/Screens/Widgets/ModalLoading.dart';
import 'package:clinicachain/Screens/Widgets/ModalSuccess.dart';
import 'package:clinicachain/Screens/Widgets/TextChain.dart';
import 'package:clinicachain/Screens/Widgets/TextFieldCustom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterPacientePage extends StatefulWidget {
  @override
  _RegisterPacientePageState createState() => _RegisterPacientePageState();
}

class _RegisterPacientePageState extends State<RegisterPacientePage> 
{

  final _nombreCompletoController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _dniController = TextEditingController();
  final _domicilioController = TextEditingController();
  final _grupoSanguineoController = TextEditingController();
  final _correoController = TextEditingController();
  final _contrasenaController = TextEditingController();

  String _fecha = '0000-00-00';

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context)
  {
    final pacienteBloc = BlocProvider.of<PacienteBloc>(context);

    return BlocListener<PacienteBloc, PacienteState>(
      listener: (context, state) {
          if( state is LoadingPacienteState ){
            modalLoading(context, 'Creando paciente...');
          
          } else if( state is SuccessPacienteState ){

            Navigator.pop(context);
            _clearCamposPaciente();
            modalSuccess(context, 'Paciente Creado');

          } else if ( state is FailurePacienteState ){

            Navigator.pop(context);
            print(state.error);
            ScaffoldMessenger.of(context).showSnackBar( SnackBar(
              content: TextChain(text: state.error, fontSize: 18, color: Colors.white ),
              backgroundColor: Colors.red,
            ));
          }
      },
      child: Scaffold(
        backgroundColor: Color(0xffF3F3F8),
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: TextChain(text: 'Registro de pacientes', letterSpacing: 1, color: Color(0xff2B57C0), fontWeight: FontWeight.w500, fontSize: 21 ),
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded, size: 22, color: Color(0xff2B57C0)),
              onPressed: () => Navigator.of(context).pop()
            ),
          ),
        body: Form(
          key: _key,
          child: ListView(
            physics: BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            children: [
              TextChain(text: 'Nombre completo', fontSize: 17),
              SizedBox(height: 5.0),
              TextFieldCustomChain(controller: _nombreCompletoController, fillColor: Colors.white, validator: RequiredValidator(errorText: 'Nombre requerido')),
              SizedBox(height: 15.0),
              TextChain(text: 'Apellidos', fontSize: 17),
              SizedBox(height: 5.0),
              TextFieldCustomChain(controller: _apellidoController, fillColor: Colors.white, validator: RequiredValidator(errorText: 'Apellidos requeridos') ),
              SizedBox(height: 15.0),
              TextChain(text: 'DNI', fontSize: 17),
              SizedBox(height: 5.0),
              TextFieldCustomChain(controller: _dniController, fillColor: Colors.white, type: TextInputType.number, hint: '12345678', validator: RequiredValidator(errorText: 'DNI requerido')),
              SizedBox(height: 15.0),
              TextChain(text: 'Domicilio', fontSize: 17),
              SizedBox(height: 5.0),
              TextFieldCustomChain(controller: _domicilioController, fillColor: Colors.white, validator: RequiredValidator(errorText: 'Domicilio requerido') ),
              SizedBox(height: 15.0),
              TextChain(text: 'Fecha de Nacimiento', fontSize: 17),
              SizedBox(height: 5.0),
              textFieldNacimiento(),
              SizedBox(height: 15.0),
              Divider(),
              TextChain(text: 'Grupo sanguineo', fontSize: 17),
              SizedBox(height: 5.0),
              TextFieldCustomChain(controller: _grupoSanguineoController, fillColor: Colors.white, validator: RequiredValidator(errorText: 'Grupo sanguineo requerido') ),
              SizedBox(height: 15.0),
              Divider(),
              TextChain(text: 'Correo Electronico', fontSize: 17),
              SizedBox(height: 5.0),
              TextFieldCustomChain(controller: _correoController, fillColor: Colors.white, type: TextInputType.emailAddress, validator: RequiredValidator(errorText: 'Correo Electronico requerido')),
              SizedBox(height: 15.0),
              TextChain(text: 'Contraseña', fontSize: 17),
              SizedBox(height: 5.0),
              TextFieldCustomChain(controller: _contrasenaController, fillColor: Colors.white, obscureText: true, validator: RequiredValidator(errorText: 'Contraseña requerido')),
              SizedBox(height: 25.0),
              BtnCustom(
                text: 'Guardar datos',
                borderRadius: 20,
                onPressed: (){
                  if( _key.currentState.validate() ){

                      pacienteBloc.add( AgregarPacienteBlockchainEvent(
                        nombre: _nombreCompletoController.text,
                        apellidos: _apellidoController.text,
                        dni: _dniController.text,
                        domicilio: _domicilioController.text,
                        nacimiento: _fecha,
                        sanguino: _grupoSanguineoController.text,
                        correo: _correoController.text,
                        contrasena: _contrasenaController.text
                      ));

                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textFieldNacimiento() {

    return Container(
      color: Colors.white,
      child: TextButton(
          onPressed: () {
            DatePicker.showDatePicker(context,
                showTitleActions: true,
                minTime: DateTime(1970, 3, 5),
                maxTime: DateTime(2003, 12, 31),
                theme: DatePickerTheme(
                    headerColor: Colors.white,
                    backgroundColor: Colors.white,
                    itemStyle: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    doneStyle: TextStyle(color: Colors.blue, fontSize: 18)
                ),
                onConfirm: (date) {
                  setState(() => _fecha = date.toString() );
                },
                currentTime: DateTime.now(), 
                locale: LocaleType.es
            );
          },
          child: TextChain( text: _fecha)),
    );

  }


  void _clearCamposPaciente(){
    _nombreCompletoController.clear();
    _apellidoController.clear();
    _dniController.clear();
    _domicilioController.clear();
    _grupoSanguineoController.clear();
    _correoController.clear();
    _contrasenaController.clear();
  }



}