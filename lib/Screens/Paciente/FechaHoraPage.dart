import 'package:clinicachain/Bloc/CitaPaciente/citapaciente_bloc.dart';
import 'package:clinicachain/Controller/DBPaciente.dart';
import 'package:clinicachain/Helpers/PersistenceData.dart';
import 'package:clinicachain/Models/Paciente/FechasDisponiblesModels.dart';
import 'package:clinicachain/Models/Paciente/HorasByFechaModels.dart';
import 'package:clinicachain/Screens/Paciente/DetailsCitaPacientePage.dart';
import 'package:clinicachain/Screens/Widgets/TextFieldCustom.dart';
import 'package:clinicachain/Screens/Widgets/Wait.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


class FechaHoraPage extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    final citaPacienteBloc = BlocProvider.of<CitapacienteBloc>(context);

    return Scaffold(
      backgroundColor: Color(0xffF3F3F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Fecha y Hora' , style: GoogleFonts.getFont('Roboto', letterSpacing: 1, color: Color(0xff2B57C0), fontWeight: FontWeight.w600)),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, size: 25, color: Color(0xff2B57C0)),
          onPressed: () => Navigator.pop(context)
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text( ConvertMeses.convertMesesToString( DateTime.now().month ), style: GoogleFonts.getFont('Roboto', fontSize: 22, letterSpacing: 1,  fontWeight: FontWeight.w600)),
                  SizedBox(width: 15),
                  Text( DateTime.now().year.toString(), style: GoogleFonts.getFont('Roboto', fontSize: 22, fontWeight: FontWeight.w600)),
                ],
              ),
            ),

            Text( 'Dias Disponibles ', style: GoogleFonts.getFont('Roboto', fontSize: 18)),
            SizedBox(height: 10),

            Expanded(
              child: FutureBuilder<List<Fechas>>(
                future: dbPaciente.getFechaHoraPacienteCita( DateTime.now().month.toString(), citaPacienteBloc.state.idEspecialista, DateTime.now().year.toString() ),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                  ? WaitMoment()
                  : ListFechas( listFechas: snapshot.data );
                },
              )
            )
            
          ],
        ),
      ),
     );
  }
}

class ListFechas extends StatelessWidget
{
  final List<Fechas> listFechas;

  const ListFechas({this.listFechas});

  @override
  Widget build(BuildContext context) 
  {
    final citaPacienteBloc = BlocProvider.of<CitapacienteBloc>(context);

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 2,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2.5
      ),
      itemCount: listFechas.length == null ? 0 : listFechas.length,
      itemBuilder: (context, i) {

        final dia = DateTime.now().day;

        if( (dia < int.parse(listFechas[i].dia)) ){

          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            elevation: 0,
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              overlayColor: MaterialStateProperty.all(Color(0xff0033A1)),
              onTap: () {
                showModalBottomForHoras(context, listFechas[i].anno, listFechas[i].mes, listFechas[i].dia);
                citaPacienteBloc.add( SelectionFecha(year: listFechas[i].anno, month: listFechas[i].mes, day: listFechas[i].dia) );
              },
              child: Center(
                child: Text( listFechas[i].dia , style: GoogleFonts.getFont('Roboto', fontSize: 19))
              )
            ),
          );

        }
        return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            elevation: 0,
            color: Colors.grey[300],
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              overlayColor: MaterialStateProperty.all(Color(0xff0033A1)),
              child: Center(
                child: Text( listFechas[i].dia , style: GoogleFonts.getFont('Roboto', fontSize: 19))
              )
            ),
          );
        
      },
    );
  }  
}


void showModalBottomForHoras(BuildContext context, String year, String month, String day, ){

  final citaPacienteBloc = BlocProvider.of<CitapacienteBloc>(context).state;

  showModalBottomSheet(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    context: context,
    builder: (context) {

      return Padding(
        padding: EdgeInsets.all(15.0),
        child: Container(
          
          color: Colors.white,
          child: FutureBuilder<List<Horas>>(
            future: dbPaciente.getHorasForFecha(year, month, day, citaPacienteBloc.idEspecialista),
            builder: (context, snapshot) {
              return !snapshot.hasData
              ? WaitMoment()
              : ListHorasPaciente( listHoras: snapshot.data );
            },
          )
        ),
      );

    },
  );

}


class ListHorasPaciente extends StatefulWidget
{
  final List<Horas> listHoras;

  const ListHorasPaciente({this.listHoras});

  @override
  _ListHorasPacienteState createState() => _ListHorasPacienteState();
}

class _ListHorasPacienteState extends State<ListHorasPaciente> 
{
  int isSelectedCard = -1;
  String selectedIdHora = '';
  String selectedHora = '';
  TextEditingController descripcionController = TextEditingController();

  @override
  Widget build(BuildContext context) 
  {
    final citaPacienteBloc = BlocProvider.of<CitapacienteBloc>(context);

    return Column(
      children: [
        Container(
          height: 5,
          width: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.grey
          ),
        ),
        SizedBox(height: 15),
        Text( 'Seleccione la hora', style: GoogleFonts.getFont('Roboto', fontSize: 18)),
        SizedBox(height: 15),
        Expanded(
          flex: 3,
          child: GridView.builder(
            itemCount: widget.listHoras.length == null ? 0 : widget.listHoras.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 2,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2.5
            ),
            itemBuilder: (context, i) {
              return Card(
                color: isSelectedCard == i ? Color(0xff306FFD) : Color(0xffF3F3F8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                elevation: 0,
                child: InkWell(
                  borderRadius: BorderRadius.circular(50.0),
                  overlayColor: MaterialStateProperty.all(Color(0xff0033A1)),
                  onTap: (){
                    setState(() {
                      isSelectedCard = i;
                      selectedIdHora = widget.listHoras[i].horasId.toString(); 
                      selectedHora = widget.listHoras[i].hora; 
                    });
                  },
                  child: Center(
                    child: Text( widget.listHoras[i].hora , style: GoogleFonts.getFont('Roboto', fontSize: 17))
                  ),
                ),
              );
            },
          ),
        ),
        TextFieldCustomChain(maxLines: 3,hint: 'Descripción de la cita', controller: descripcionController),
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text('Cancelar', style: GoogleFonts.getFont('Roboto', fontSize: 18)),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                  child: Text('Confirmar Cita', style: GoogleFonts.getFont('Roboto', fontSize: 18)),
                  onPressed: (){
                    citaPacienteBloc.add( SelectionHora(idHora: selectedIdHora, hora: selectedHora, descripcion: descripcionController.text.trim()) );
                    Navigator.push(context, MaterialPageRoute(builder: (_) => DetailsCitaPacientePage()));
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
