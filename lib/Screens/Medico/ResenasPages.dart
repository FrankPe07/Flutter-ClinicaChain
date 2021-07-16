import 'package:clinicachain/Bloc/Auth/auth_bloc.dart';
import 'package:clinicachain/Controller/DBMedico.dart';
import 'package:clinicachain/Helpers/Drawer.dart';
import 'package:clinicachain/Helpers/DrawerAdmin.dart';
import 'package:clinicachain/Models/Medico/ResenasMedicasModels.dart';
import 'package:clinicachain/Screens/Widgets/TextChain.dart';
import 'package:clinicachain/Screens/Widgets/Wait.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ResenasPage extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    final _scafolkey = new GlobalKey<ScaffoldState>();
    final authBloc = BlocProvider.of<AuthBloc>(context).state;
    
    return Scaffold(
      key: _scafolkey,
      drawer: DrawerCustom().drawerCustom( authBloc.idrolStorage, context, '${authBloc.nombreStorage} ${authBloc.lastnameStorage}', authBloc.emailStorage, DrawerSeccions.resenasMedico),
      backgroundColor: Color(0xffF3F3F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextChain(text: 'Reseñas', letterSpacing: 1, color: Color(0xff2B57C0), fontWeight: FontWeight.w600, fontSize: 19),
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<List<ResenasMedico>>(
          future: dbMedico.getResenasMedicas(),
          builder: (context, snapshot) {
            return !snapshot.hasData
            ? WaitMoment()
            : ListComentarios(listResenas: snapshot.data );
          },
        ),
      ),
     );
  }
}

class ListComentarios extends StatelessWidget {

  final List<ResenasMedico> listResenas;

  const ListComentarios({ this.listResenas});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listResenas.length == null ? 0 : listResenas.length,
      itemBuilder: (context, i) {
        return Container(
          padding: EdgeInsets.all(15.0),
          height: 110,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TextChain(text: 'Calificación: ', fontWeight: FontWeight.w500, fontSize: 19),
                  Icon(Icons.star_rate_rounded, color: Colors.amber),
                  Icon(Icons.star_rate_rounded, color: Colors.amber),
                  Icon(Icons.star_rate_rounded, color: Colors.amber),
                  Icon(Icons.star_rate_rounded, color: Colors.amber),
                  Icon(Icons.star_rate_rounded, color: Colors.amber),
                ],
              ),
              SizedBox(height: 10.0),
              Wrap(
                children: [
                  TextChain(text: 'Comentario: ', fontWeight: FontWeight.w600, fontSize: 19),
                  TextChain(text:  listResenas[i].opinion, fontSize: 17),
                  
                ],
              )
            ],
          ),
        );
      },
    );
  }
}