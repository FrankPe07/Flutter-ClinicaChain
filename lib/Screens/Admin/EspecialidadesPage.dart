import 'package:clinicachain/Bloc/Auth/auth_bloc.dart';
import 'package:clinicachain/Controller/DBAmin.dart';
import 'package:clinicachain/Helpers/Drawer.dart';
import 'package:clinicachain/Helpers/DrawerAdmin.dart';
import 'package:clinicachain/Models/Admin/EspecialidadesMedicasModels.dart';
import 'package:clinicachain/Screens/Admin/AddEspecialidadPage.dart';
import 'package:clinicachain/Screens/Widgets/Wait.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


class EspecialidadesPage extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    final _scafolkey = new GlobalKey<ScaffoldState>();
    final authBloc = BlocProvider.of<AuthBloc>(context).state;
    
    return Scaffold(
      key: _scafolkey,
      drawer: DrawerCustom().drawerCustom( authBloc.idrolStorage, context, '${authBloc.nombreStorage} ${authBloc.lastnameStorage}', authBloc.emailStorage, DrawerSeccions.especialidadesAdmin),
      backgroundColor: Color(0xffF3F3F8),
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
              icon: Icon(Icons.add, color: Colors.white, size: 20,),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AddEspecialidadPage())),
            )
          ),
          SizedBox(width: 5)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
        child: FutureBuilder<List<Especialidades>>(
          future: dbAdmin.getEspecialidadesMedicasAdmin(),
          builder: (context, snapshot) {
            return !snapshot.hasData
            ? WaitMoment()
            : ListEspecialidades( listEspecialidad: snapshot.data ); 
          },
        ),
      ),
     );
  }
}

class ListEspecialidades extends StatelessWidget
{
  final List<Especialidades> listEspecialidad;

  const ListEspecialidades({ @required this.listEspecialidad });

  @override
  Widget build(BuildContext context)
  {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: listEspecialidad.length == null ? 0 : listEspecialidad.length,
      itemBuilder: (context, i) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 0,
          child: Dismissible(
            key: Key(listEspecialidad[i].id.toString()),
            background: Container(
              padding: EdgeInsets.only(left: 15),
              alignment: Alignment.centerLeft,
              color: Color(0xff292D33),
              child: Icon(Icons.edit_outlined, size: 32, color: Colors.white)
            ),
            secondaryBackground: Container(
              padding: EdgeInsets.only(right: 15),
              alignment: Alignment.centerRight,
              color: Colors.red,
              child: Icon(Icons.delete_sweep_outlined, size: 32, color: Colors.white)
            ),
            child: ListTile(
              title: Text(listEspecialidad[i].especialidad, style: GoogleFonts.getFont('Roboto', fontSize: 18, fontWeight: FontWeight.w500)),
              subtitle: Text(listEspecialidad[i].descripcion, style: GoogleFonts.getFont('Roboto', fontSize: 16)),
            ),
          ),
        );
      },
    );
  }

}