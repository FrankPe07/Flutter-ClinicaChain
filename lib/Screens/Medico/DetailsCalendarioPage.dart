import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clinicachain/Controller/DBMedico.dart';
import 'package:clinicachain/Models/Medico/DetailsCalendarioModels.dart';
import 'package:clinicachain/Screens/Widgets/Wait.dart';
import 'package:table_calendar/table_calendar.dart';

class DetailsCalendarioPage extends StatefulWidget
{
  final String mes;
  final String year;

  const DetailsCalendarioPage({ @required this.mes, @required this.year });

  @override
  _DetailsCalendarioPageState createState() => _DetailsCalendarioPageState();
}

class _DetailsCalendarioPageState extends State<DetailsCalendarioPage> 
{
  DateTime _selectedDay;


  @override
  Widget build(BuildContext context)
  {

    return Scaffold(
      backgroundColor: Color(0xffF3F3F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Detalle Calendario', style: GoogleFonts.getFont('Roboto', letterSpacing: 1, color: Color(0xff2B57C0), fontWeight: FontWeight.w600)),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, size: 22, color: Color(0xff2B57C0)),
          onPressed: () => Navigator.pop(context)
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              height: 395,
              child: Center(
                child: TableCalendar(
                  locale: 'es_ES',
                  focusedDay: DateTime.utc(int.parse(widget.year), int.parse(widget.mes), 1),
                  firstDay: DateTime.utc(int.parse(widget.year), int.parse(widget.mes), 1),
                  lastDay: DateTime.utc(int.parse(widget.year), int.parse(widget.mes), 31),
                  availableGestures: AvailableGestures.none,
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    titleTextStyle: GoogleFonts.getFont('Roboto', fontSize: 20),
                    formatButtonVisible: false,
                  ),
                  calendarStyle: CalendarStyle(
                    defaultTextStyle: GoogleFonts.getFont('Roboto'),
                    selectedDecoration: BoxDecoration(
                      color: Color(0xff0033A1),
                      shape: BoxShape.circle
                    ),
                    selectedTextStyle: GoogleFonts.getFont('Roboto', fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
                    holidayTextStyle: TextStyle(color: Colors.red),
                    weekendTextStyle: TextStyle(color: Colors.red),
                  ),
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    showModalButtom( context, _selectedDay.day.toString(), widget.mes, widget.year );

                  });
                },
                )
              ),
            ),

            Expanded(
              child: Container(
                child: FutureBuilder<List<Calendario>>(
                  future: dbMedico.getCalendarioByMonthAndYear( widget.mes , widget.year ),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                    ? WaitMoment()
                    : ListCalendarioDetails( listCalendario : snapshot.data );
                  },
                )
              ),
            ),
            
          ],
        ),
      ),
     );
  }
}


class ListCalendarioDetails extends StatelessWidget
{
  final List<Calendario> listCalendario;

  const ListCalendarioDetails({ this.listCalendario});


  @override
  Widget build(BuildContext context) 
  {
    return GridView.builder(
      itemCount: listCalendario.length == null ? 0 : listCalendario.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 2,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2.5
      ),
      itemBuilder: (context, i) {
        
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          elevation: 0,
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            overlayColor: MaterialStateProperty.all(Color(0xff0033A1)),
            onTap: () => showModalButtom( context, listCalendario[i].dia, listCalendario[i].mes, listCalendario[i].anno ),
            child: Center(
              child: Text( listCalendario[i].dia, style: GoogleFonts.getFont('Roboto', fontSize: 19))
            )
          ),
        );
      },
    );
  }
  
}


showModalButtom(BuildContext context, String day, String month, String year){

  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),  
    builder: (context) {
      return Container(
        padding: EdgeInsets.all(10.0),
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
        ),
        child: Column(
          children: [
            Container(
              height: 5,
              width: 65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: FutureBuilder<List>(
                future: dbMedico.getHorasbyMonths(day, month, year),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                  ?WaitMoment()
                  : ListHorasByMonth( listHoras: snapshot.data );
                },
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xff306FFD),
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)), 
              ),
              child: Text('Cerrar', style: GoogleFonts.getFont('Roboto', fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1)),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      );
    },
  );

}

class ListHorasByMonth extends StatelessWidget
{
  final List listHoras;

  const ListHorasByMonth({ this.listHoras});

  @override
  Widget build(BuildContext context) 
  {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 2,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2.5
      ),
      itemCount: listHoras.length == null ? 0 : listHoras.length,
      itemBuilder: (context, i) {
        return Card(
          color: Color(0xffF3F3F8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          elevation: 0,
          child: Center(child: Text( listHoras[i]['hora'] , style: GoogleFonts.getFont('Roboto', fontSize: 17)))
        );
      },
    );
  }

  
}