import 'package:clinicachain/Bloc/Auth/auth_bloc.dart';
import 'package:clinicachain/Helpers/Drawer.dart';
import 'package:clinicachain/Helpers/DrawerAdmin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


class TerminosPage extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    final _scafolkey = new GlobalKey<ScaffoldState>();
    final authBloc = BlocProvider.of<AuthBloc>(context).state;
    
    return Scaffold(
      key: _scafolkey,
      backgroundColor: Colors.white,
      drawer: DrawerCustom().drawerCustom( authBloc.idrolStorage, context, '${authBloc.nombreStorage} ${authBloc.lastnameStorage}', authBloc.emailStorage, DrawerSeccions.terminos),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Terminos de uso', style: GoogleFonts.getFont('Roboto', letterSpacing: 1, color: Color(0xff2B57C0), fontWeight: FontWeight.w600)),
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
            child: Text('${authBloc.nombreStorage.substring(0,1)}', style: GoogleFonts.getFont('Roboto', color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 15)
        ],
      ),
      body: Center(
         child: Text(' Frave Developer', style: GoogleFonts.getFont('Roboto', fontSize: 20)),
      ),
     );
  }
}