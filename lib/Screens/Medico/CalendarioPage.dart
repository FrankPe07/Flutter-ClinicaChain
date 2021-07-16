import 'package:clinicachain/Bloc/Auth/auth_bloc.dart';
import 'package:clinicachain/Controller/DBMedico.dart';
import 'package:clinicachain/Helpers/Drawer.dart';
import 'package:clinicachain/Helpers/DrawerAdmin.dart';
import 'package:clinicachain/Helpers/PersistenceData.dart';
import 'package:clinicachain/Screens/Medico/DetailsCalendarioPage.dart';
import 'package:clinicachain/Screens/Widgets/BtnCustom.dart';
import 'package:clinicachain/Screens/Widgets/TextChain.dart';
import 'package:clinicachain/Screens/Widgets/Wait.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CalendarioPage extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    final _scafolkey = new GlobalKey<ScaffoldState>();
    final authBloc = BlocProvider.of<AuthBloc>(context).state;
    
    return Scaffold(
      key: _scafolkey,
      drawer: DrawerCustom().drawerCustom( authBloc.idrolStorage, context, '${authBloc.nombreStorage} ${authBloc.lastnameStorage}', authBloc.emailStorage, DrawerSeccions.calendarioMedico),
      backgroundColor: Color(0xffF3F3F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextChain(text: 'Calendario Medico', letterSpacing: 1, color: Color(0xff2B57C0), fontWeight: FontWeight.w600, fontSize: 19),
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
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List>(
                future: dbMedico.getCalentarioMedico(),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                  ? WaitMoment()
                  : ListMeses( listMonth: snapshot.data );
                },
              ),
            ),
            BtnCustom(text: 'Agregar nuevo calendario', borderRadius: 50, colorTwo: Color(0xff306FFD), onPressed: () => Navigator.pushNamed(context, 'addNewCalendarioPage'))
          ],
        ),
      ),
     );
  }
}

class ListMeses extends StatelessWidget
{
  final List listMonth;

  const ListMeses({this.listMonth});
  @override
  Widget build(BuildContext context)
  {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: listMonth.length == null ? 0 : listMonth.length,
      itemBuilder: (context, i) {
        
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 0,
          child: InkWell(
            child: ListTile(
              leading: Icon(Icons.today_outlined, size: 28, color: Color(0xff5396F0)),
              title: TextChain(text: '${ConvertMeses.convertMesesToString(int.parse(listMonth[i]["mes"]))}  ${listMonth[i]["anno"]}', fontSize: 18),
              trailing: Icon(Icons.arrow_forward_ios_rounded, size: 20),
            ),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailsCalendarioPage(mes: listMonth[i]["mes"], year: listMonth[i]["anno"]))),
          ),
        );
      },
    );
  }
  
}