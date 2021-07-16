import 'package:clinicachain/Bloc/CalendarMedico/calendarmedico_bloc.dart';
import 'package:clinicachain/Controller/DBMedico.dart';
import 'package:clinicachain/Models/Medico/HorasModels.dart';
import 'package:clinicachain/Screens/Widgets/Wait.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';


class AddNewCalendarioPage extends StatefulWidget
{
  @override
  _AddNewCalendarioPageState createState() => _AddNewCalendarioPageState();
}

class _AddNewCalendarioPageState extends State<AddNewCalendarioPage> 
{
  DateTime _selectedDay;
  bool isSelected = false;

  @override
  Widget build(BuildContext context)
  {
    final calendarMedicoBloc = BlocProvider.of<CalendarmedicoBloc>(context);

    return Scaffold(
      backgroundColor: Color(0xffF3F3F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Nuevo Calendario', style: GoogleFonts.getFont('Roboto', letterSpacing: 1, color: Color(0xff2B57C0), fontWeight: FontWeight.w600)),
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

            Center(
              child: TableCalendar(
                locale: 'es_ES',
                rangeStartDay: DateTime.now(),
                focusedDay:  DateTime.now(),
                lastDay: DateTime.utc(2030, 3, 14),
                firstDay: DateTime.now(),
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
                availableGestures: AvailableGestures.horizontalSwipe,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    print(_selectedDay);
                    calendarMedicoBloc.add( SelectionDate( day: _selectedDay.day, month: _selectedDay.month, year: _selectedDay.year ) );
                    showHorasAvalibles();
                  });
                },
                
              ),
            ),

            SizedBox(height: 15),
            Text('Horas disponibles', style: GoogleFonts.getFont('Roboto', fontSize: 18))

          ],
        ),
      ),
     );
  }

  showHorasAvalibles(){

    final calendarMedicoBloc = BlocProvider.of<CalendarmedicoBloc>(context);

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      isDismissible: false,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            height: 340,
            decoration: BoxDecoration(
              color: Colors.white
            ),
            child: FutureBuilder<List<Horas>>(
              future: dbMedico.getAllHoras(),
              builder: (context, snapshot) {
                
                return !snapshot.hasData
                ? WaitMoment()
                : Column(
                  children: [
                    Container(
                      height: 5,
                      width: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey
                      ),
                    ),
                    SizedBox(height: 15),
                    Text( 'Seleccione su horario', style: GoogleFonts.getFont('Roboto', fontSize: 18)),
                    SizedBox(height: 10),
                    Expanded(
                      child: _ListHorasGridView(listHoras: snapshot.data),
                    ),

                    Row(
                      children: [
                        TextButton(
                          child: Text('Cancelar', style: GoogleFonts.getFont('Roboto', fontSize: 18)),
                          onPressed: (){
                             calendarMedicoBloc.add( ClearSelectedHoras() );
                             Navigator.pop(context);
                          }, 
                        ),
                        SizedBox(width: 15),
                        TextButton(
                          child: Text('Confirmar Horario', style: GoogleFonts.getFont('Roboto', fontSize: 18)),
                          onPressed: () {

                              Navigator.pop(context);
                              calendarMedicoBloc.add( SaveCalendarMedico() );
                              calendarMedicoBloc.add( ClearSelectedHoras() );
                              Navigator.pushReplacementNamed(context, 'calendarioPage');
                          }, 
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        );
      },
    );

  }

}

class _ListHorasGridView extends StatelessWidget 
{
  final List<Horas> listHoras;
  
  const _ListHorasGridView({ @required this.listHoras });

  @override
  Widget build(BuildContext context) 
  {
    final calendarMedicoBloc = BlocProvider.of<CalendarmedicoBloc>(context);
    List<int> idHoras = [];


    return GridView.builder(
      itemCount: listHoras.length == null ? 0 : listHoras.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 2,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2.5
      ),
      itemBuilder: (context, i) {
        
        return BlocBuilder<CalendarmedicoBloc, CalendarmedicoState>(
            builder: (context, state) {
              
              return Card(
                color: state.idHoras.contains(listHoras[i].id) ? Colors.blue : Color(0xffF3F3F8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                elevation: 0,
                child: InkWell(
                  onTap: () {
                    
                    if( state.idHoras.contains(listHoras[i].id) ){

                      idHoras.remove( listHoras[i].id );
                      calendarMedicoBloc.add( RemoveItemIdhora(id: listHoras[i].id ) );

                    }else {
                      idHoras.add( listHoras[i].id );
                      calendarMedicoBloc.add( SelectedHoras( horas: idHoras ) );
                    }
                    
                    print('State ${calendarMedicoBloc.state.idHoras}');

                  },
                  child: Center(
                    child: Text( listHoras[i].hora , style: GoogleFonts.getFont('Roboto', fontSize: 17))
                  ),
                )
              );


            },
        );
      },
    );
  }
}
