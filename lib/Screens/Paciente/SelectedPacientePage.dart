import 'package:clinicachain/Bloc/CitaPaciente/citapaciente_bloc.dart';
import 'package:clinicachain/Controller/DBPaciente.dart';
import 'package:clinicachain/Models/GrupoFamiliar.dart';
import 'package:clinicachain/Screens/Paciente/FechaHoraPage.dart';
import 'package:clinicachain/Screens/Widgets/TextChain.dart';
import 'package:clinicachain/Screens/Widgets/Wait.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SelectedPacientePage extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Color(0xffF3F3F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextChain(text: 'Seleccionar Paciente', letterSpacing: 1, color: Color(0xff2B57C0), fontWeight: FontWeight.w600),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, size: 25, color: Color(0xff2B57C0)),
          onPressed: () => Navigator.pop(context)
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 4.0, left: 6.0, right: 6.0),
        child: FutureBuilder<List<GrupoFamiliarElement>>(
          future: dbPaciente.grupoFamiliarPaciente(),
          builder: (context, snapshot) {

            return !snapshot.hasData
            ? WaitMoment()
            : ListPacientes(listPaciente: snapshot.data );
          },
        ),
      ),
     );
  }
}


class ListPacientes extends StatelessWidget
{
  final List<GrupoFamiliarElement> listPaciente;

  const ListPacientes({this.listPaciente});

  @override
  Widget build(BuildContext context)
  {
    final citaPacienteBloc = BlocProvider.of<CitapacienteBloc>(context);

    return ListView.builder(
      itemCount: listPaciente == null ? 0 : listPaciente.length,
      itemBuilder: (context, i) {

        var annio = int.parse(listPaciente[i].fechaNacimiento.toString().substring(0,4));
        final edad = DateTime.now().year - annio;
        
        return InkWell(
          onTap: (){
            citaPacienteBloc.add( SelectedPaciente(idPaciente: listPaciente[i].pacienteId.toString(), nombrePaciente: '${listPaciente[i].nombre} ${listPaciente[i].apellidos}', parentesco: listPaciente[i].parentesco ));
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => FechaHoraPage()));
          },
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(0xff306FFD).withOpacity(.9),
                child: TextChain(text: '${listPaciente[i].nombre.substring(0,1).toUpperCase()}', color: Colors.white, fontWeight: FontWeight.bold),
              ),
              title: TextChain(text: '${listPaciente[i].nombre} ${listPaciente[i].apellidos}', fontSize: 16.5, fontWeight: FontWeight.w500),
              subtitle: TextChain(text: '$edad Años', fontSize: 15, color: Colors.grey),
              trailing: listPaciente[i].familiaId == null
                        ? TextChain(text: 'Principal', fontSize: 15, color: Color(0xff306FFD))
                        : TextChain(text: '${listPaciente[i].parentesco}', fontSize: 15, color: Color(0xff26D786)),
            ),
          ),
        );
      },
    );
  }
}