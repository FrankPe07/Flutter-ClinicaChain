import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:clinicachain/Bloc/Auth/auth_bloc.dart';
import 'package:clinicachain/Controller/DBMedico.dart';
import 'package:clinicachain/Helpers/Drawer.dart';
import 'package:clinicachain/Helpers/DrawerAdmin.dart';
import 'package:clinicachain/Models/Medico/MedicoModels.dart';
import 'package:clinicachain/Screens/Widgets/BtnCustom.dart';
import 'package:clinicachain/Screens/Widgets/ModalSuccess.dart';
import 'package:clinicachain/Screens/Widgets/TextChain.dart';
import 'package:clinicachain/Screens/Widgets/TextFieldCustom.dart';
import 'package:clinicachain/Screens/Widgets/Wait.dart';


class DatosGeneralesPage extends StatefulWidget
{
  @override
  _DatosGeneralesPageState createState() => _DatosGeneralesPageState();
}

class _DatosGeneralesPageState extends State<DatosGeneralesPage> 
{

  MedicoModels medico;

  bool _isLoading = false;
  int _selectedSexo = 0;

  TextEditingController _name = TextEditingController();
  TextEditingController _lastname = TextEditingController();
  TextEditingController _dni = TextEditingController();
  TextEditingController _lugarNacimiento = TextEditingController();
  TextEditingController _descMedica = TextEditingController();
  TextEditingController _direccionMedica = TextEditingController();
  TextEditingController _cpm;
  TextEditingController _rne;


  obtenerDatosGenerales() async {

    medico = await dbMedico.getMedico();

    setState(() {
      _isLoading =  medico.resp;
      
      _name = TextEditingController(text: medico.persona.nombre );
      _lastname = TextEditingController(text: medico.persona.apellidos );
      _dni = TextEditingController(text: medico.persona.dni );
      _selectedSexo = medico.persona.genero;
      _lugarNacimiento = TextEditingController(text: medico.persona.lugarNacimiento );
      _descMedica = TextEditingController(text: medico.medico.description );
      _direccionMedica = TextEditingController(text: medico.medico.direccionConsulta );
      _cpm = TextEditingController(text: medico.medico.cpm );
      _rne = TextEditingController(text: medico.medico.rne );

    });

  }

  @override
  void initState() {
    obtenerDatosGenerales();
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    final _scafolkey = new GlobalKey<ScaffoldState>();
    final authBloc = BlocProvider.of<AuthBloc>(context).state;

    return Scaffold(
      key: _scafolkey,
      drawer: DrawerCustom().drawerCustom( authBloc.idrolStorage, context, '${authBloc.nombreStorage} ${authBloc.lastnameStorage}', authBloc.emailStorage, DrawerSeccions.datosGeneralesMedico),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextChain(text: 'Datos Generales', letterSpacing: 1, color: Color(0xff2B57C0), fontWeight: FontWeight.w600, fontSize: 19),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.sort, size: 29, color: Color(0xff2B57C0)),
          onPressed: () => _scafolkey.currentState.openDrawer()
        ),
        actions: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Color(0xff2B57C0),
            child: TextChain(text: '${authBloc.nombreStorage.substring(0,1).toUpperCase()}', color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 15)
        ],
      ),
      body: _isLoading ? Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Form(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                TextChain(text: 'Nombre', fontSize: 17),
                SizedBox(height: 3),
                TextFieldCustomChain(controller: _name),
                SizedBox(height: 10),
                TextChain(text: 'Apellidos', fontSize: 17),
                SizedBox(height: 3),
                TextFieldCustomChain(controller: _lastname),
                SizedBox(height: 10),
                TextChain(text: 'DNI', fontSize: 17),
                SizedBox(height: 3),
                TextFieldCustomChain(controller: _dni, readOnly: true, ),
                SizedBox(height: 10),
                TextChain(text: 'Sexo', fontSize: 17),
                SizedBox(height: 3),
                _sexo(),
                TextChain(text: 'Lugar de nacimiento', fontSize: 17),
                SizedBox(height: 3),
                TextFieldCustomChain(controller: _lugarNacimiento ),
                SizedBox(height: 10),
                TextChain(text: 'Descripción medica', fontSize: 17),
                SizedBox(height: 3),
                TextFieldCustomChain(controller: _descMedica ),
                SizedBox(height: 10),
                TextChain(text: 'Direccion consulta', fontSize: 17),
                SizedBox(height: 3),
                TextFieldCustomChain(controller: _direccionMedica, maxLines: 3,),
                SizedBox(height: 10),
                TextChain(text: 'CPM', fontSize: 17),
                SizedBox(height: 3),
                TextFieldCustomChain(controller: _cpm, readOnly: true),
                SizedBox(height: 10),
                TextChain(text: 'RNE', fontSize: 17),
                SizedBox(height: 3),
                TextFieldCustomChain(controller: _rne, readOnly: true),

                SizedBox(height: 30),
                BtnCustom(
                  text: 'Actualizar Datos', 
                  borderRadius: 50, 
                  onPressed: () async {
                    final resp = await dbMedico.updateDatosMedicos(
                        name: _name.text, 
                        lastname: _lastname.text,
                        sex: _selectedSexo,
                        lugar: _lugarNacimiento.text,
                        description: _descMedica.text,
                        consultorio: _direccionMedica.text
                    );

                    if( resp ) modalSuccess(context, 'Actualización exitosa');

                  }
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ) : WaitMoment(),
     );
  }

  Widget _sexo(){
    return Container(
      child: Row(
        children: [
          Radio(
            value: 1,
            groupValue: _selectedSexo,
            activeColor: Color(0xff2B57C0),
            onChanged: (v) => setState(() => _selectedSexo = v),
          ),
          TextChain(text: 'Masculino', fontSize: 17),
          SizedBox(width: 20),
          Radio(
            value: 0,
            groupValue: _selectedSexo,
            activeColor: Color(0xff2B57C0),
            onChanged: (v) => setState(() => _selectedSexo = v),
          ),
          TextChain(text: 'Femenino', fontSize: 17),
        ],
      ),
    );
  }








}