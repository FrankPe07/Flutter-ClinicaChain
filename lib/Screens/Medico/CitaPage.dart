import 'package:clinicachain/Bloc/Auth/auth_bloc.dart';
import 'package:clinicachain/Bloc/HistorialClinico/historialclinico_bloc.dart';
import 'package:clinicachain/Controller/DBMedico.dart';
import 'package:clinicachain/Helpers/Drawer.dart';
import 'package:clinicachain/Helpers/DrawerAdmin.dart';
import 'package:clinicachain/Models/Medico/CitaMedicaModels.dart';
import 'package:clinicachain/Screens/Medico/HistoriaClinicaPage.dart';
import 'package:clinicachain/Screens/Widgets/BtnCustom.dart';
import 'package:clinicachain/Screens/Widgets/TextChain.dart';
import 'package:clinicachain/Screens/Widgets/Wait.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pin_put/pin_put.dart';


class CitasPage extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    final _scafolkey = new GlobalKey<ScaffoldState>();
    final authBloc = BlocProvider.of<AuthBloc>(context).state;
    
    return Scaffold(
      key: _scafolkey,
      backgroundColor: Color(0xffF3F3F8),
      drawer: DrawerCustom().drawerCustom( authBloc.idrolStorage , context, '${authBloc.nombreStorage} ${authBloc.lastnameStorage}', authBloc.emailStorage, DrawerSeccions.citasMedico),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextChain(text: 'Citas', letterSpacing: 1, color: Color(0xff2B57C0), fontWeight: FontWeight.w600, fontSize: 19),
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
        padding: EdgeInsets.all(10.0),
        child: FutureBuilder<List<CitasMedico>>(
          future: dbMedico.getCitasMedicas(),
          builder: (context, snapshot) {
            return !snapshot.hasData
            ? WaitMoment()
            : ListCitasMedicas( listCitas: snapshot.data );
          },
        ),
      ),
     );
  }
}

class ListCitasMedicas extends StatelessWidget
{
  final List<CitasMedico> listCitas;

  const ListCitasMedicas({ this.listCitas });

  @override
  Widget build(BuildContext context) 
  {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: listCitas.length == null ? 0 : listCitas.length,
      itemBuilder: (context, i) {
        return DesignCitasMedicas(citasMedico: listCitas[i] );
      },
    );
  }
  
}


class DesignCitasMedicas extends StatelessWidget
{
  final CitasMedico citasMedico;

  const DesignCitasMedicas({ @required this.citasMedico });
   
  @override
  Widget build(BuildContext context) 
  {
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      height: 300,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(10),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xff3A4960),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
            ),
            child: Center(
              child: Text( citasMedico.especialidad , style: GoogleFonts.getFont('Roboto', fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold))
            ),
          ),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            height: 140,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Paciente: ', style: GoogleFonts.getFont('Roboto', fontSize: 18, fontWeight: FontWeight.w600)),
                    SizedBox(width: 15),
                    Text(citasMedico.paciente , style: GoogleFonts.getFont('Roboto', fontSize: 18)),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Text('Fecha: ', style: GoogleFonts.getFont('Roboto', fontSize: 18, fontWeight: FontWeight.w600)),
                    SizedBox(width: 35),
                    Text('${citasMedico.dia} / ${citasMedico.mes} / ${citasMedico.anno} : ${citasMedico.hora}', style: GoogleFonts.getFont('Roboto', fontSize: 18)),
                  ],
                ),
                SizedBox(height: 15),
                Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    Text('Dirección: ', style: GoogleFonts.getFont('Roboto', fontSize: 18, fontWeight: FontWeight.w600)),
                    Text('${citasMedico.direccionConsulta}', style: GoogleFonts.getFont('Roboto', fontSize: 18)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: BtnCustom(
                    text: 'Ver Historial', 
                    borderRadius: 50, 
                    height: 50, 
                    colorTwo: Color(0xff1E58AC),
                    onPressed: () => showModelBottomValidationCode(context, citasMedico.id.toString(), citasMedico.pacienteId.toString(), citasMedico.especialidad),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffEAEFF5)
                    ),
                    child: citasMedico.calificacion != null
                      ? Icon(Icons.star_border_rounded, color: Colors.yellow, size: 40)
                      : Icon(Icons.star_border_rounded, color: Colors.grey, size: 40)
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffEAEFF5)
                    ),
                    child: citasMedico.condicion == 1
                      ? Icon(Icons.done, size: 35, color: Colors.green,)
                      : Icon(Icons.close_rounded, size: 35, color: Colors.grey,),
                  ),
                ),
              ],
            ),
          )
          
        ],
      ),
    );
  }
  
}

showModelBottomValidationCode(BuildContext context, String idCita, String idPaciente, String especialidad ){

  TextEditingController codToken;

  final historiaClinicaBloc = BlocProvider.of<HistorialclinicoBloc>(context);

  showDialog(
    context: context, 
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        content: Container(
          height: 200,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('Codigo de acceso', style: GoogleFonts.getFont('Roboto', fontSize: 22, fontWeight: FontWeight.w600)),
                SizedBox(height: 10),
                Divider(),
                Container(
                  height: 50,
                  width: 400,
                  child: PinPut(
                    controller: codToken,
                    fieldsCount: 6,
                    textStyle: GoogleFonts.getFont('Roboto', fontSize: 18, fontWeight: FontWeight.w600),
                    withCursor: true,
                    followingFieldDecoration: BoxDecoration(
                        color: Color(0xffECEBEE),
                        borderRadius: BorderRadius.circular(9.0)
                    ),
                    selectedFieldDecoration: BoxDecoration(
                        border: Border.all(color: Colors.deepPurpleAccent),
                        borderRadius: BorderRadius.circular(9.0)
                    ),
                    submittedFieldDecoration: BoxDecoration(
                        color: Color(0xffECEBEE),
                        borderRadius: BorderRadius.circular(9.0)
                    ),
                  ),
                ),
                Divider(),
                SizedBox(height: 10),
                BtnCustom(text: 'Validar token', onPressed: (){
                  
                  //*TODO ACCESS DATABASE TOKEN */
                  
                  Navigator.pop(context);
                  historiaClinicaBloc.add( SelectionPaciente(idCita: idCita, idPaciente: idPaciente, movitoConsulta: especialidad) );
                  Navigator.push(context, MaterialPageRoute(builder: (_) => HistoriaClinicaPage()));

                })
              ],
            ),
          ),
        ),
      );
    },
  );

}