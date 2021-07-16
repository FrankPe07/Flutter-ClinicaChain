import 'package:clinicachain/Bloc/CitaPaciente/citapaciente_bloc.dart';
import 'package:clinicachain/Controller/DBPaciente.dart';
import 'package:clinicachain/Models/MedicoEspecialista.dart';
import 'package:clinicachain/Screens/Paciente/DetailsEspecialistaPage.dart';
import 'package:clinicachain/Screens/Widgets/TextChain.dart';
import 'package:clinicachain/Screens/Widgets/Wait.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MedicoEspecialistaPage extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    final citaPaciente = BlocProvider.of<CitapacienteBloc>(context);

    return Scaffold(
      backgroundColor: Color(0xffF3F3F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextChain( text: 'Medicos Especialistas', letterSpacing: 1, color: Color(0xff2B57C0), fontWeight: FontWeight.w600),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, size: 25, color: Color(0xff2B57C0)),
          onPressed: () => Navigator.pop(context)
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 4),
        child: FutureBuilder<List<Especialista>>(
          future: dbPaciente.getMedicosEspecialistas( citaPaciente.state.idEspecialidad ),
          builder: (context, snapshot) {

            return !snapshot.hasData
            ? WaitMoment()
            : ItemList( listEspecialista: snapshot.data );
          },
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget
{
  final List<Especialista> listEspecialista;

  const ItemList({this.listEspecialista});

  @override
  Widget build(BuildContext context)
  {
    final citaPaciente = BlocProvider.of<CitapacienteBloc>(context);

    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: listEspecialista == null ? 0 : listEspecialista.length,
      itemBuilder: (context, i) {
        
        return Container(
            padding: EdgeInsets.only( left: 3.0, right: 3.0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              elevation: 0,
              child: InkWell(
                onTap: (){
                  citaPaciente.add( SelectedMedicoEspecialista(idMedico: listEspecialista[i].medicoId.toString(), nombreMedico: listEspecialista[i].nombre, lastNameMedico: listEspecialista[i].apellidos, direccionEspecialista: listEspecialista[i].direccionConsulta  ));
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => DetailsEspecialistaPage(listEspecialidad: listEspecialista[i])));
                },
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: Color(0xff306FFD),
                    child: TextChain(text: listEspecialista[i].letra, fontSize: 17, color: Colors.white, fontWeight: FontWeight.w700),  
                  ),
                  title: TextChain( text: 'Dr. ${listEspecialista[i].nombre} ${listEspecialista[i].apellidos}', fontSize: 19, fontWeight: FontWeight.w500),
                  subtitle: TextChain(text: listEspecialista[i].especialidad, fontSize: 16, color: Colors.grey),
                  trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.black87, size: 20)
              ),
            ),
          ),
        );
      },
    );
  }
}