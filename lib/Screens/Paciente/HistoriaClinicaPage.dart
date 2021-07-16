import 'package:clinicachain/Bloc/Auth/auth_bloc.dart';
import 'package:clinicachain/Controller/DBPaciente.dart';
import 'package:clinicachain/Helpers/Drawer.dart';
import 'package:clinicachain/Helpers/DrawerAdmin.dart';
import 'package:clinicachain/Models/Paciente/ListadoHistoriasPacienteResponse.dart';
import 'package:clinicachain/Screens/Paciente/HistoriaBlockchainPage.dart';
import 'package:clinicachain/Screens/Widgets/TextChain.dart';
import 'package:clinicachain/Screens/Widgets/Wait.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HistoriaClinicaPacientePage extends StatelessWidget
{
  

  @override
  Widget build(BuildContext context)
  {
    final _scafolkey = new GlobalKey<ScaffoldState>();
    final authBloc = BlocProvider.of<AuthBloc>(context).state;

    
    return Scaffold(
      key: _scafolkey,
      backgroundColor: Color(0xffF3F3F8),
      drawer: DrawerCustom().drawerCustom( authBloc.idrolStorage, context, '${authBloc.nombreStorage} ${authBloc.lastnameStorage}', authBloc.emailStorage, DrawerSeccions.historiaClinicaPaciente),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextChain(text: 'Historias Clinicas', letterSpacing: 1, color: Color(0xff2B57C0), fontWeight: FontWeight.w500, fontSize: 22 ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.sort, size: 29, color: Color(0xff2B57C0)),
          onPressed: () => _scafolkey.currentState.openDrawer()
        ),
      ),
      body: FutureBuilder<List<Historia>>(
        future: dbPaciente.obtenerListaHistoriaClinicaPaciente(id: authBloc.idPersonaStora ),
        builder: (_, snapshot) {
          
          return !snapshot.hasData
            ? WaitMoment()
            : ListHistorialPaciente( listHistoria: snapshot.data );
        },
      ),
    );
  }
}

class ListHistorialPaciente extends StatelessWidget {

  final List<Historia> listHistoria;

  const ListHistorialPaciente({this.listHistoria});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      itemCount: listHistoria.length == null ? 0 : listHistoria.length,
      itemBuilder: (_, i) 
        => Card(
            margin: EdgeInsets.only(bottom: 10.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            shadowColor: Colors.black54,
            child: InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => HistoriaBlockchainPage(idHistoria: listHistoria[i].id.toString()))),
              child: ListTile(
                title: TextChain(text: listHistoria[i].motivoConsulta, fontWeight: FontWeight.w600, fontSize: 20 ),
                subtitle: TextChain(text: listHistoria[i].fecha.toString()),
                trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.blue),
              ),
            ),
        ),
    );
  }
}