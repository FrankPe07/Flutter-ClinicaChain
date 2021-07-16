import 'package:clinicachain/Bloc/HistorialClinico/historialclinico_bloc.dart';
import 'package:clinicachain/Controller/DBMedico.dart';
import 'package:clinicachain/Models/Medico/HistorialClinicoModels.dart';
import 'package:clinicachain/Screens/Medico/AddHistorialClinico.dart';
import 'package:clinicachain/Screens/Widgets/Wait.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


class HistoriaClinicaPage extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    final historiaClinicaBloc = BlocProvider.of<HistorialclinicoBloc>(context);
    
    return Scaffold(
      backgroundColor: Color(0xffF3F3F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Hitorial Clinico', style: GoogleFonts.getFont('Roboto', letterSpacing: 1, color: Color(0xff2B57C0), fontWeight: FontWeight.w600)),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, size: 22, color: Color(0xff2B57C0)),
          onPressed: () => Navigator.pop(context)
        ),
        actions: [
          CircleAvatar(
            radius: 18,
            child: IconButton(
              icon: Icon(Icons.addchart_outlined, size: 22),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AddHistorialClinicoPage())),
            ),
          ),
          SizedBox(width: 10.0)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: FutureBuilder<HistorialClinicoModels>(
          future: dbMedico.getHistorrialClinicoPaciente( historiaClinicaBloc.state.idPaciente ),
          builder: (context, snapshot) {

            return !snapshot.hasData
            ? WaitMoment()
            : _HistorialClinicoDetails(historiaClinica: snapshot.data );

          },
        ),
      ),
    );
  }
}

class _HistorialClinicoDetails extends StatelessWidget {

  final HistorialClinicoModels historiaClinica;

  const _HistorialClinicoDetails({ this.historiaClinica });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
          height: 130,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0)
          ),
          child: Row(
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: Color(0xff306FFD),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Text('${ historiaClinica.persona.nombre.substring(0,1).toUpperCase()}${historiaClinica.persona.apellidos.substring(0,1).toUpperCase()}', style: GoogleFonts.getFont('Roboto', fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold )),
                ),
              ), 
              SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text( historiaClinica.persona.nombre , style: GoogleFonts.getFont('Roboto', fontSize: 25, fontWeight: FontWeight.w600)),
                  Text( historiaClinica.persona.apellidos , style: GoogleFonts.getFont('Roboto', fontSize: 21, fontWeight: FontWeight.w600)),
                  Text('26 Años', style: GoogleFonts.getFont('Roboto', fontSize: 17)),
                  Text( historiaClinica.paciente.grupoSanguineo , style: GoogleFonts.getFont('Roboto', fontSize: 17)),
                ],
              )
            ],
          )
        ),
        SizedBox(height: 15),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Diagnosticos anteriores', style: GoogleFonts.getFont('Roboto', fontSize: 18, color: Colors.grey)),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: historiaClinica.historial.length == null ? 0 : historiaClinica.historial.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(width: .6, color: Color(0xff306FFD))
                          ),
                          elevation: 0,
                          child: ListTile(
                            title: Text( historiaClinica.historial[i].motivoConsulta, style: GoogleFonts.getFont('Roboto', fontSize: 17)),
                            subtitle: Text( historiaClinica.historial[i].fecha.toString(), style: GoogleFonts.getFont('Roboto', fontSize: 17)),
                          )
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}