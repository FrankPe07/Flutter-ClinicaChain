import 'package:clinicachain/Bloc/Auth/auth_bloc.dart';
import 'package:clinicachain/Screens/Widgets/TextChain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinicachain/Controller/DBMedico.dart';
import 'package:clinicachain/Helpers/Drawer.dart';
import 'package:clinicachain/Helpers/DrawerAdmin.dart';
import 'package:clinicachain/Models/Medico/ServiciosPreciosModels.dart';
import 'package:clinicachain/Screens/Widgets/BtnCustom.dart';
import 'package:clinicachain/Screens/Widgets/Wait.dart';


class ServicioPrecioPage extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    final _scafolkey = new GlobalKey<ScaffoldState>();
    final authBloc = BlocProvider.of<AuthBloc>(context).state;

    return Scaffold(
      key: _scafolkey,
      drawer: DrawerCustom().drawerCustom( authBloc.idrolStorage, context, '${authBloc.nombreStorage} ${authBloc.lastnameStorage}', authBloc.emailStorage, DrawerSeccions.serviciosMedico),
      backgroundColor: Color(0xffF3F3F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextChain(text: 'Servicios y Precios', letterSpacing: 1, color: Color(0xff2B57C0), fontWeight: FontWeight.w600),
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
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Servicio>>(
                future: dbMedico.getServiciosPreciosMedico(),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                  ? WaitMoment()
                  : ListServicio( listService: snapshot.data);
                },
              ),
            ),
            BtnCustom(text: 'Agregar Servicio', borderRadius: 50, colorTwo: Color(0xff306FFD), onPressed: () => Navigator.pushNamed(context, 'addServicioPrecio')),
            SizedBox(height: 15)
          ],
        ),
      ),
     );
  }
}

class ListServicio extends StatelessWidget{

  final List<Servicio> listService;

  const ListServicio({this.listService});

  @override
  Widget build(BuildContext context)
  {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: listService == null ? 0 : listService.length,
      itemBuilder: (context, i) {
        
        return Container(
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: TextChain(text: listService[i].tipoServicio.nombreServicio, fontSize: 18, fontWeight: FontWeight.w400),
                subtitle: TextChain(text: listService[i].descripcion,  fontSize: 15, color: Colors.grey),
                trailing: TextChain(text: 'S/ ${listService[i].precio}',  fontSize: 16)
              ),
            ),
          ),
        );
      },
    );
  }
}