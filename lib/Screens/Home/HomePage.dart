import 'package:clinicachain/Bloc/Auth/auth_bloc.dart';
import 'package:clinicachain/Controller/DBHome.dart';
import 'package:clinicachain/Helpers/Drawer.dart';
import 'package:clinicachain/Helpers/DrawerAdmin.dart';
import 'package:clinicachain/Helpers/Helper.dart';
import 'package:clinicachain/Models/TopMedicosModels.dart';
import 'package:clinicachain/Screens/Widgets/TextChain.dart';
import 'package:clinicachain/Screens/Widgets/Wait.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    final _scafolkey = new GlobalKey<ScaffoldState>();
    final size = MediaQuery.of(context).size;
    final authBloc = BlocProvider.of<AuthBloc>(context).state;

    return Scaffold(
      key: _scafolkey,
      drawer: DrawerCustom().drawerCustom( authBloc.idrolStorage , context, '${authBloc.nombreStorage} ${authBloc.lastnameStorage}', authBloc.emailStorage, DrawerSeccions.home),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          children: [
            Container(
              height: kToolbarHeight,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  TextChain(text: 'CLINICA CHAIN', fontSize: 20, color: Color(0xff2B57C0), fontWeight: FontWeight.bold ),
                  CircleAvatar(
                    backgroundColor: Color(0xff2B57C0),
                    radius: 25,
                    child: TextButton(
                      child: TextChain(text: '${authBloc.nombreStorage.substring(0,1).toUpperCase()}', color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                      onPressed: () => _scafolkey.currentState.openDrawer(),
                    ),
                  )
                ]
              ),
            ),
            SizedBox(height: 10),
            TextChain(text: '${TimeZoneCustom.getDia(DateTime.now().hour)}', fontSize: 35, fontWeight: FontWeight.bold, color: Color(0xff3A4960)),
            TextChain(text: '${authBloc.nombreStorage}', fontSize: 40, color: Color(0xff2B57C0), fontWeight: FontWeight.bold ),
            
            SizedBox(height: 30),
            TextFormField(
              style: GoogleFonts.getFont('Roboto', fontSize: 18),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Buscar especialidades / medicos',
                hintStyle: GoogleFonts.getFont('Inter', color: Color(0xff2B57C0).withOpacity(0.3)),
                filled: true,
                fillColor: Color(0xffEFF3F6),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: BorderSide.none
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: BorderSide.none
                ),
                suffixIcon: Icon(Icons.search_rounded, color: Color(0xff2B57C0).withOpacity(0.4))
              ),
            ),

            SizedBox(height: 30.0),
            TextChain(text: 'Especialidades', fontSize: 18, color: Colors.grey[600]),

            SizedBox(height: 15.0),
            Container(
              height: 200,
              width: size.width,
              child: FutureBuilder<List>(
                future: dbHome.getTopEspecialidades(),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                  ? WaitMoment()
                  : ListTopEspecialidades( listTopEspecialidades: snapshot.data );
                },
              )
            ),

            SizedBox(height: 20.0),
            TextChain(text: 'Top Medicos', fontSize: 18, color: Colors.grey[600]),

            SizedBox(height: 10.0),

            Container(
              height: 350,
              child: FutureBuilder<List<TopMedico>>(
                future: dbHome.getTopHome(),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                  ? WaitMoment()
                  : ListTopMedico( listTopMedico: snapshot.data );
                },
              ),
            )
          ],
        ),
      )
    );
  }
}

class ListTopMedico extends StatelessWidget {

  final List<TopMedico> listTopMedico;

  const ListTopMedico({this.listTopMedico});

  @override
  Widget build(BuildContext context) 
  {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: listTopMedico.length == null ? 0 : listTopMedico.length,
      itemBuilder: (context, i) {
        return _CardMedicos(medico: listTopMedico[i]);
      },
    );
  }

  
}


class _CardMedicos extends StatelessWidget {

  final TopMedico medico;

  const _CardMedicos({ @required this.medico});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      height: 100,
      decoration: BoxDecoration(
        color: Color(0xffF3F3F8),
        borderRadius: BorderRadius.circular(15.0)
      ),
      child: Row(
        children: [
          SizedBox(width: 15.0),
          CircleAvatar(
            backgroundColor: Color(0xff3A4960),
            radius: 35,
            child: TextChain(text: medico.initial , fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(width: 25.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextChain(text:'Dr. ${medico.nombre} ${medico.apellidos}', fontSize: 20, fontWeight: FontWeight.bold),
              TextChain(text: medico.description, fontSize: 17),
              Row(
                children: [
                  Icon(Icons.star, color: Color(0xff2B57C0)),
                  TextChain(text:'4.6', fontSize: 16),
                ],
              ),
            ],
          )
        ],
      )
    );
  }
}


class ListTopEspecialidades extends StatelessWidget{

  final List listTopEspecialidades;
  final List<Color> listColors = [
    Color(0xff306FFD), Color(0xffFF9418), Color(0xff515DE1),
    Color(0xff89113B), Color(0xff26D786), Color(0xff306FFD),
    Color(0xffFFA136), Color(0xff5A4A9E), Color(0xff89113B),
    Color(0xff26D786),
  ];

  ListTopEspecialidades({this.listTopEspecialidades});

  @override
  Widget build(BuildContext context) 
  {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      itemCount: listTopEspecialidades.length,
      itemBuilder: (context, i) {
        
        return Container(
          margin: EdgeInsets.only(right: 10.0),
          padding: EdgeInsets.all(10.0),
          height: 170,
          width: 130,
          decoration: BoxDecoration(
            color: listColors[i],
            borderRadius: BorderRadius.circular(25.0)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite_border, size: 75 ,color: Colors.white),
              SizedBox(height: 15.0),
              Center(child: TextChain(text: listTopEspecialidades[i]['Especialidad'], fontSize: 19, color: Colors.white)),
            ],
          ),
        );

      },
    );
  }



}
