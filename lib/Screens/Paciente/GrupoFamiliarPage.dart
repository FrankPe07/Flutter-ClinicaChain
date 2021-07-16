import 'package:clinicachain/Bloc/Auth/auth_bloc.dart';
import 'package:clinicachain/Controller/DBPaciente.dart';
import 'package:clinicachain/Helpers/Drawer.dart';
import 'package:clinicachain/Helpers/DrawerAdmin.dart';
import 'package:clinicachain/Models/GrupoFamiliar.dart';
import 'package:clinicachain/Screens/Widgets/BtnCustom.dart';
import 'package:clinicachain/Screens/Widgets/Wait.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


class GrupoFamiliarPage extends StatelessWidget
{
  
  @override
  Widget build(BuildContext context)
  {
    final _scafolkey = new GlobalKey<ScaffoldState>();
    final authBloc = BlocProvider.of<AuthBloc>(context).state;

    return Scaffold(
      key: _scafolkey,
      backgroundColor: Color(0xffF3F3F8),
      drawer: DrawerCustom().drawerCustom( authBloc.idrolStorage, context, '${authBloc.nombreStorage} ${authBloc.lastnameStorage}', authBloc.emailStorage, DrawerSeccions.grupoFamiliarPaciente),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Grupo Familiar', style: GoogleFonts.getFont('Roboto', letterSpacing: 1, color: Color(0xff2B57C0), fontWeight: FontWeight.w600)),
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
            child: Text( authBloc.nombreStorage.substring(0,1).toUpperCase() , style: GoogleFonts.getFont('Roboto', color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 15)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
        child: Stack(
          children: [

            FutureBuilder<List<GrupoFamiliarElement>>(
              future: dbPaciente.grupoFamiliarPaciente(),
              builder: (context, snapshot) {
                return !snapshot.hasData
                ? WaitMoment()
                : ItemList(list: snapshot.data );
              },
            ),
              
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: BtnCustom(
                text: 'Agregar Familiar', 
                borderRadius: 50, 
                colorTwo: Color(0xff2B57C0),
                onPressed: () => Navigator.of(context).pushNamed('addPacientePage'),
              )
            ),
            
          ],
        ),
      ),
     );
  }
}

class ItemList extends StatelessWidget
{
  final List<GrupoFamiliarElement> list;

  const ItemList({this.list});

  @override
  Widget build(BuildContext context)
  {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {

        var annio = int.parse(list[i].fechaNacimiento.toString().substring(0,4));
        final edad = DateTime.now().year - annio;
        
        return Padding(
          padding: EdgeInsets.only(bottom: 2.5),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            child: InkWell(
              onTap: (){},
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(0xff306FFD).withOpacity(.9),
                  child: Text('${list[i].nombre.substring(0,1)}', style: GoogleFonts.getFont('Roboto', color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                title: Text( '${list[i].nombre} ${list[i].apellidos}', style: GoogleFonts.getFont('Roboto', fontSize: 16.5, fontWeight: FontWeight.w500)),
                subtitle: Text('$edad Años', style: GoogleFonts.getFont('Roboto', fontSize: 15, color: Colors.grey)),
                trailing: list[i].familiaId == null
                          ? Text('Principal', style: GoogleFonts.getFont('Roboto', fontSize: 15, color: Color(0xff306FFD)))
                          : Text('${list[i].parentesco}', style: GoogleFonts.getFont('Roboto', fontSize: 15, color: Color(0xff26D786))),
              ),
            ),
          ),
        );
      },
    );
  }


  
}