import 'package:clinicachain/Bloc/Auth/auth_bloc.dart';
import 'package:clinicachain/Controller/DBPaciente.dart';
import 'package:clinicachain/Helpers/Drawer.dart';
import 'package:clinicachain/Helpers/DrawerAdmin.dart';
import 'package:clinicachain/Models/Paciente/CitasMedicasPacienteModels.dart';
import 'package:clinicachain/Screens/Widgets/BtnCustom.dart';
import 'package:clinicachain/Screens/Widgets/TextChain.dart';
import 'package:clinicachain/Screens/Widgets/TextFieldCustom.dart';
import 'package:clinicachain/Screens/Widgets/Wait.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MisCitasPage extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    final _scafolkey = new GlobalKey<ScaffoldState>();
    final authBloc = BlocProvider.of<AuthBloc>(context).state;
    
    return Scaffold(
      key: _scafolkey,
      backgroundColor: Color(0xffF3F3F8),
      drawer: DrawerCustom().drawerCustom( authBloc.idrolStorage, context, '${authBloc.nombreStorage} ${authBloc.lastnameStorage}', authBloc.emailStorage, DrawerSeccions.misCitasPaciente),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextChain(text: 'Mis Citas' , letterSpacing: 1, color: Color(0xff2B57C0), fontWeight: FontWeight.w600),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.sort, size: 29, color: Color(0xff2B57C0)),
          onPressed: () => _scafolkey.currentState.openDrawer()
        ),
        actions: [
          CircleAvatar(
            radius: 15,
            backgroundColor: Color(0xff2B57C0),
            child: TextChain(text: authBloc.nombreStorage.substring(0,1).toUpperCase(), color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 15)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: FutureBuilder<List<Citas>>(
          future: dbPaciente.getCitasMedicasPaciente(),
          builder: (context, snapshot) {
            return !snapshot.hasData
            ? WaitMoment()
            : ListCitas( listCitas: snapshot.data );
          },
        )
      ),
     );
  }
}



class ListCitas extends StatelessWidget {

  final List<Citas> listCitas;

  const ListCitas({ this.listCitas});

  @override
  Widget build(BuildContext context) 
  {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: listCitas.length == null ? 0 : listCitas.length,
      itemBuilder: (context, i) => _DetailsCitaMedica(cita: listCitas[i])
    );
  }

  

}


class _DetailsCitaMedica extends StatelessWidget {

  final Citas cita;

  const _DetailsCitaMedica({ @required this.cita});
  
  @override
  Widget build(BuildContext context) 
  {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      padding: EdgeInsets.all(10.0),
      height: 350,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Color(0xff306FFD),
                child: TextChain(text: '${cita.paciente.substring(0,2).toUpperCase()}', fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(width: 10.0),
              TextChain(text: cita.paciente, fontSize: 20)
            ],
          ),
          Divider(),
          TextChain(text: 'Datos Medicos', fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey),
          TextChain(text: cita.medico),
          SizedBox(height: 5.0),
          TextChain(text: cita.especialidad),

          SizedBox(height: 8.0),
          TextChain(text: 'Dirección', fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey),
          
          SizedBox(height: 3.0),
          TextChain(text: cita.direccionConsulta ),

          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextChain(text: 'Fecha', fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey),
              TextChain(text: '${cita.dia}/${cita.mes}/${cita.anno}'),
            ],
          ),
          SizedBox(height: 3.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextChain(text: 'Hora', fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey),
              TextChain(text: '${cita.hora}'),
            ],
          ),
          SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: ( int.parse(cita.dia) < DateTime.now().day  && int.parse(cita.anno) < DateTime.now().year ) 
                  ? BtnCustom(text: 'Generar codigo' , borderRadius: 50,colorTwo: Color(0xff292D33), colorOne: Color(0xff292D33))
                  : BtnCustom(
                      text: 'Generar codigo',
                      borderRadius: 50,
                      colorTwo: Color(0xff1E58AC), 
                      onPressed: () async {
                        String token = await dbPaciente.getTokenAccessHistorial( cita.id.toString() );
                        if( token != '' ) modalTokenAccess( context , token);
                      },
                    ) 
              ),
              Expanded(
                flex: 1,
                child: CircleAvatar(
                  radius: 28,
                  child: IconButton(
                    icon: Icon(Icons.thumb_up_alt_outlined, size: 28),
                    onPressed: () => modalComentario(context),
                  ),
                )
              ),
              Expanded(
                flex: 1,
                child: CircleAvatar(
                  radius: 28,
                  child: IconButton(
                    icon: Icon(Icons.check, size: 28),
                    onPressed: (){},
                  ),
                )
              ),
            ],
          )
        ],
      ),
    );
  }
}



void modalTokenAccess( BuildContext context, String tokenAccess ){

  showDialog(
    barrierDismissible: false,
    context: context, 
    builder: (context) {
      
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        content: Container(
          height: 165,
          child: Column(
            children: [
                TextChain(text: 'CODIGO DE SEGURIDAD',  fontSize: 22),
                Divider(),
                SizedBox(height: 20.0),
                TextChain(text: tokenAccess,  fontSize: 27),
                SizedBox(height: 20.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      child: TextChain( text: 'Aceptar', fontSize: 20),
                      onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
            ], 
        ),
        ),
      );

    },
  );

}


void modalComentario( BuildContext context ){

  showDialog(
    barrierDismissible: false,
    context: context, 
    builder: (context) {
      
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        content: Container(
          height: 250,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
                TextChain(text: 'Valora la atención', fontSize: 22),
                Divider(),
                SizedBox(height: 5.0),
                Icon(Icons.star_outline_rounded, size: 38),
                SizedBox(height: 10.0),
                TextFieldCustomChain(maxLines: 3, hint: 'Escribe un comentario',),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: TextChain(text: 'Cerrar', fontSize: 20),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    TextButton(
                      child: TextChain(text: 'Valorar', fontSize: 20),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                )
            ], 
        ),
        )
      );
      
    },
  );

}



