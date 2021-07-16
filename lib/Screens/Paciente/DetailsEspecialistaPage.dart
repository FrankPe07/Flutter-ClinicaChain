import 'package:clinicachain/Controller/DBPaciente.dart';
import 'package:clinicachain/Models/ServicioPrecioOfMedico.dart';
import 'package:clinicachain/Screens/Widgets/BtnCustom.dart';
import 'package:clinicachain/Screens/Widgets/TextChain.dart';
import 'package:clinicachain/Screens/Widgets/Wait.dart';
import 'package:flutter/material.dart';
import 'package:clinicachain/Models/MedicoEspecialista.dart';

class DetailsEspecialistaPage extends StatelessWidget
{
  final Especialista listEspecialidad;

  const DetailsEspecialistaPage({ @required this.listEspecialidad});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Color(0xffF3F3F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextChain(text: 'Medico ${listEspecialidad.nombre}', letterSpacing: 1, color: Color(0xff2B57C0), fontWeight: FontWeight.w600),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, size: 25, color: Color(0xff2B57C0)),
          onPressed: () => Navigator.pop(context)
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DescriptionMedico(listEspecialidad: listEspecialidad),
            SizedBox(height: 15.0),
            TextChain(text: 'Servicios y Precios'),
            SizedBox(height: 15.0),
            Expanded(
              child: FutureBuilder(
                future: dbPaciente.getServiciosPreciosOfMedico( listEspecialidad.medicoId.toString() ),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                  ? WaitMoment()
                  : ListServicios(listServicio: snapshot.data );
                },
              ),
            ),
            BtnCustom(
              text: 'REALIZAR CITA',
              colorTwo: Color(0xff306FFD), 
              borderRadius: 50,
              onPressed: () => Navigator.pushNamed(context, 'selectedPaciente')
            )
          ],
        ),
      ),
     );
  }
}

class _DescriptionMedico extends StatelessWidget {
  
  final Especialista listEspecialidad;

  const _DescriptionMedico({ @required this.listEspecialidad });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      height: 195,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0)
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  shape: BoxShape.circle
                ),
                child: Center(
                  child: TextChain(text: '${listEspecialidad.nombre.substring(0,1).toUpperCase()}${listEspecialidad.apellidos.substring(0,1).toUpperCase()}', fontSize: 25,)
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextChain(text: 'Dr. ${listEspecialidad.nombre} ${listEspecialidad.apellidos}', fontSize: 20),
                  TextChain(text: listEspecialidad.especialidad, fontSize: 18, color: Colors.grey),
                  TextChain(text: listEspecialidad.descripcion, fontSize: 16, color: Colors.grey),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextChain(text:' CPM:  ${listEspecialidad.cpm}', fontSize: 17),
              TextChain(text:' RNE:  ${listEspecialidad.rne}', fontSize: 17),
            ],
          ),
          SizedBox(height: 15),
          TextChain(text:'Dirección', fontSize: 17),
          TextChain(text:'${listEspecialidad.direccionConsulta}', fontSize: 17),
        ],
      ),
    );
  }
}


class ListServicios extends StatelessWidget{

  final List<Servicio> listServicio;

  const ListServicios({this.listServicio});

  @override
  Widget build(BuildContext context)
  {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: listServicio == null ? 0 : listServicio.length,
      itemBuilder: (context, i) {
        
        return Container(
          margin: EdgeInsets.only(bottom: 5.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            elevation: 0,
            child: ListTile(
              title: TextChain(text: listServicio[i].nombreServicio, fontSize: 17, fontWeight: FontWeight.w500),
              trailing: TextChain(text: 'S/ ${listServicio[i].precio}', fontSize: 15, color: Colors.green[900])
            ),
          ),
        );
      },
    );
  }
}