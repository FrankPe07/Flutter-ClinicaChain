import 'package:clinicachain/Bloc/Auth/auth_bloc.dart';
import 'package:clinicachain/Bloc/CitaPaciente/citapaciente_bloc.dart';
import 'package:clinicachain/Controller/DBPaciente.dart';
import 'package:clinicachain/Helpers/Drawer.dart';
import 'package:clinicachain/Helpers/DrawerAdmin.dart';
import 'package:clinicachain/Models/EspecialidadesMedicasModels.dart';
import 'package:clinicachain/Screens/Paciente/BusquedaEspecialidadPage.dart';
import 'package:clinicachain/Screens/Widgets/Wait.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


class BuscarEspecialidadPage extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    final _scafolkey = new GlobalKey<ScaffoldState>();
    final authBloc = BlocProvider.of<AuthBloc>(context).state;

    return Scaffold(
      key: _scafolkey,
      backgroundColor: Color(0xffF3F3F8),
      drawer: DrawerCustom().drawerCustom( authBloc.idrolStorage, context, '${authBloc.nombreStorage} ${authBloc.lastnameStorage}', authBloc.emailStorage, DrawerSeccions.buscarEspecialidadPaciente),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Especialidades Medicas', style: GoogleFonts.getFont('Roboto', letterSpacing: 1, color: Color(0xff2B57C0), fontWeight: FontWeight.w600)),
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
            child: IconButton(
              icon: Icon(Icons.search_rounded, size: 20, color: Colors.white),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: BusquedaEspecialidadPage(),
                  // query: 'Buscar'
                );
              }
            ),
          ),
          SizedBox(width: 15)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 4.0),
        child: FutureBuilder<List<Especialidades>>(
          future: dbPaciente.getEspecialidadesMedicas(''),
          builder: (context, snapshot) {

            return !snapshot.hasData
            ? WaitMoment()
            : ItemList( list: snapshot.data );
          },
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget
{
  final List<Especialidades> list;

  const ItemList({this.list});

  @override
  Widget build(BuildContext context)
  {
    final citaPaciente = BlocProvider.of<CitapacienteBloc>(context);

    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        
        return Container(
          padding: EdgeInsets.only( left: 3.0, right: 3.0),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            child: InkWell(
              onTap: (){
                citaPaciente.add( SeleccionarEspecialidad(idEspecialidad: list[i].id.toString(), nombreEspecialidad: list[i].especialidad ) );
                Navigator.of(context).pushNamed('medicoEspecialista');
              },
              child: ListTile(
                title: Text( list[i].especialidad, style: GoogleFonts.getFont('Roboto', fontSize: 17, fontWeight: FontWeight.w500)),
                subtitle: Text( list[i].descripcion , style: GoogleFonts.getFont('Roboto', fontSize: 15, color: Colors.grey)),
                trailing: Icon(Icons.arrow_forward_ios_outlined, color: Colors.grey[400])
              ),
            ),
          ),
        );
      },
    );
  }
}