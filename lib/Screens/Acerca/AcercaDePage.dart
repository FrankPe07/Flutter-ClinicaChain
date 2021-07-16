import 'package:clinicachain/Bloc/Auth/auth_bloc.dart';
import 'package:clinicachain/Helpers/Drawer.dart';
import 'package:clinicachain/Helpers/DrawerAdmin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


class AcercaDePage extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    final _scafolkey = new GlobalKey<ScaffoldState>();
    final authBloc = BlocProvider.of<AuthBloc>(context).state;
    
    return Scaffold(
      key: _scafolkey,
      backgroundColor: Colors.white,
      drawer: DrawerCustom().drawerCustom( authBloc.idrolStorage, context, '${authBloc.nombreStorage} ${authBloc.lastnameStorage}', authBloc.emailStorage, DrawerSeccions.acerca),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Acerca De', style: GoogleFonts.getFont('Roboto', letterSpacing: 1, color: Color(0xff2B57C0), fontWeight: FontWeight.w600)),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text('CLINICA CHAIN', style: GoogleFonts.getFont('Roboto', fontWeight: FontWeight.bold, fontSize: 28))),
          SizedBox(height: 5),
          Center(child: Text('Versión 2.1.10', style: GoogleFonts.getFont('Roboto',  fontSize: 17))),
          SizedBox(height: 5),
          Center(child: Text('Tiene la ultima versión estable instalada.', style: GoogleFonts.getFont('Roboto',  fontSize: 16))),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.copyright_rounded),
              SizedBox(width: 5),
              Text('Frave Developer', style: GoogleFonts.getFont('Roboto',  fontSize: 16)),
            ],
          )
        ],
      ),
     );
  }
}