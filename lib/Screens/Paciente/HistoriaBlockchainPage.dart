import 'package:clinicachain/Bloc/Auth/auth_bloc.dart';
import 'package:clinicachain/Controller/DBPaciente.dart';
import 'package:clinicachain/Models/Paciente/HistoriaClinicaBlockchainResponse.dart';
import 'package:clinicachain/Screens/Widgets/TextChain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HistoriaBlockchainPage extends StatelessWidget
{

  final String idHistoria;

  const HistoriaBlockchainPage({ @required this.idHistoria});

  @override
  Widget build(BuildContext context)
  {
    final authBloc = BlocProvider.of<AuthBloc>(context).state;

    return Scaffold(
      backgroundColor: Color(0xffF4F4F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextChain(text: 'Historia Clinica', fontSize: 22, color: Color(0xff2B57C0), letterSpacing: 1.0, fontWeight: FontWeight.w500 ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 22 ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder<HistoriaClinica>(
        future: dbPaciente.obtenerHistoriaClinicaDeBlockchain(idHistoria: idHistoria, dni: authBloc.dni),
        builder: (context, snapshot) {
          return !snapshot.hasData
          ? _WatingBlockchain()
          : DatosHistoriaClinica(historia: snapshot.data );
        },
      ),
    );
  }
}

class _ContainerDatos extends StatelessWidget {
  
  final String title;
  final String subtitle;

  const _ContainerDatos({this.title, this.subtitle});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0)
      ),
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextChain(text: title, fontWeight: FontWeight.w500, fontSize: 20 ),
          SizedBox(height: 10),
          TextChain(text: subtitle, fontSize: 19),
        ],
      ),
    );
  }
}


class _WatingBlockchain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
       child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
            CircularProgressIndicator(color: Colors.blue, backgroundColor: Colors.green ),
            SizedBox(width: 15.0),
            TextChain(text: 'Espere, estamos cargando su información...'),
         ],
       ),
    );
  }
}


class DatosHistoriaClinica extends StatelessWidget {

  final HistoriaClinica historia;

  const DatosHistoriaClinica({this.historia});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      physics: BouncingScrollPhysics(),
      children: [
        _ContainerDatos(title: 'Datos Medicos', subtitle: '${historia.medicoNombre} ${historia.medicoApellidos}'),

        _ContainerDatos(title: 'Fecha ', subtitle: '${historia.fechaCita}' ),

        _ContainerDatos(title: 'Motivo Consulta', subtitle: historia.motivoConsulta ),

        _ContainerDatos(title: 'anamnesis', subtitle: historia.anamnesis ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(width: 210, child: _ContainerDatos(title: 'Temperatura', subtitle: historia.temperatura )),
            Container(width: 160, child: _ContainerDatos(title: 'Pulso', subtitle: historia.pulso )),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(width: 120, child: _ContainerDatos(title: 'FC', subtitle: historia.fc )),
            Container(width: 120, child: _ContainerDatos(title: 'FR', subtitle: historia.fr )),
            Container(width: 120, child: _ContainerDatos(title: 'PA', subtitle: historia.pa )),
          ],
        ),
        _ContainerDatos(title: 'Diagnostico', subtitle: historia.diagnostico ),
        _ContainerDatos(title: 'Examen Clinico', subtitle: historia.examenClinico ),
        _ContainerDatos(title: 'Tratamiento', subtitle: historia.tratamiento ),
        _ContainerDatos(title: 'Proxima Cita', subtitle: historia.proximaCita ),
      ],
    );
  }

}


