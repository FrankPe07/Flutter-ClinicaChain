import 'package:clinicachain/Bloc/CitaPaciente/citapaciente_bloc.dart';
import 'package:clinicachain/Screens/Home/HomePage.dart';
import 'package:clinicachain/Screens/Widgets/BtnCustom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


class DetailsCitaPacientePage extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    final size = MediaQuery.of(context).size;
    final citaPacienteBloc = BlocProvider.of<CitapacienteBloc>(context);

    return BlocListener<CitapacienteBloc, CitapacienteState>(
      listener: (context, state) {

            if ( state is LoadingCitaPaciente ){

              dialogLoading(context);

            } else if( state is SuccessCitaPaciente ){

              dialogSuccess(context);
            
            }
      },
      child: Scaffold(
        backgroundColor: Color(0xffF4F4F8),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Detalle de la cita' , style: GoogleFonts.getFont('Roboto', letterSpacing: 1, color: Color(0xff2B57C0), fontWeight: FontWeight.w600)),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded, size: 25, color: Color(0xff2B57C0)),
            onPressed: () => Navigator.pop(context)
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                height: 70,
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)
                ),
                child: Center(
                  child: Text('Detalle de la cita medica', style: GoogleFonts.getFont('Roboto', fontSize: 22, fontWeight: FontWeight.w500))
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10.0),
                height: 170,
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text('Medico Especialista', style: GoogleFonts.getFont('Roboto', fontSize: 20, fontWeight: FontWeight.w500 ))
                    ),
                    SizedBox(height: 15),
                    _DetailsWidget(icon: Icons.done, text: '${citaPacienteBloc.state.nombreEspecialista} ${citaPacienteBloc.state.apellidosEspecialista}'),
                    SizedBox(height: 10.0),
                    _DetailsWidget(icon: Icons.done, text: '${citaPacienteBloc.state.especialidad}'),
                    SizedBox(height: 10.0),
                    _DetailsWidget(icon: Icons.done, text: '${citaPacienteBloc.state.direccionEspecialista}'),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.all(10.0),
                height: 140,
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text('Paciente', style: GoogleFonts.getFont('Roboto', fontSize: 20, fontWeight: FontWeight.w500 ))
                    ),
                    SizedBox(height: 15),
                    _DetailsWidget(icon: Icons.done, text: '${citaPacienteBloc.state.nombrePaciente}'),
                    SizedBox(height: 10.0),
                    _DetailsWidget(icon: Icons.done, text: ' ${citaPacienteBloc.state.parentescoPaciente}'),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.all(10.0),
                height: 100,
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text('Fecha y Hora', style: GoogleFonts.getFont('Roboto', fontSize: 20, fontWeight: FontWeight.w500 ))
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _DetailsWidget(icon: Icons.date_range_outlined, text: '${citaPacienteBloc.state.day} / ${citaPacienteBloc.state.mes} / ${citaPacienteBloc.state.year}'),
                        _DetailsWidget(icon: Icons.timer, text: '${citaPacienteBloc.state.hora}'),
                      
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              BtnCustom(
                text: 'Confirmar Cita', 
                borderRadius: 50, 
                colorTwo: Color(0xff306FFD),
                onPressed: (){
                  citaPacienteBloc.add( ConfirmarCitaPaciente(
                    idEspecialista: citaPacienteBloc.state.idEspecialista,
                    idPaciente: citaPacienteBloc.state.idPacienteAtender,
                    idHora: citaPacienteBloc.state.idHora,
                    idEspecilidad: citaPacienteBloc.state.idEspecialidad,
                    descripcion: citaPacienteBloc.state.descriptionCita
                  ));
                },
              )
            ],
          ),
        ),
       ),
    );
  }
}


class _DetailsWidget extends StatelessWidget {

  final String text;
  final IconData icon;

  const _DetailsWidget({ this.text, this.icon });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(width: 10),
        Text( text , style: GoogleFonts.getFont('Roboto', fontSize: 18 )),
      ],
    );
  }
}


void dialogLoading( BuildContext context ){

  showDialog(
    barrierDismissible: false,
    context: context, 
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
            height: 90,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Text('Creando Cita...', style: GoogleFonts.getFont('Roboto', fontSize: 25, color: Color(0xff1A60C1))),
                SizedBox(height: 35.0),
                LinearProgressIndicator(backgroundColor: Color(0xff1A60C1)),
              ],
            ),
          ),
        );
    },
  );

}

void dialogSuccess( BuildContext context ){

  showDialog(
    barrierDismissible: false,
    context: context, 
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
            height: 230,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Text('Cita creada', style: GoogleFonts.getFont('Roboto', fontSize: 25, color: Color(0xff1A60C1))),
                SizedBox(height: 15.0),
                Icon(Icons.check_circle, size: 95, color: Colors.green,),
                SizedBox(height: 25.0),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 10.0),
                    backgroundColor: Color(0xff306FFD).withOpacity(.2)
                  ),
                  child: Text('Cerrar', style: GoogleFonts.getFont('Roboto', fontSize: 18, color: Color(0xff306FFD))),
                  onPressed: () => Navigator.pushAndRemoveUntil( context ,MaterialPageRoute(builder: (_) => HomePage()), (route) => false)
                )
              ],
            ),
          )
        );
    },
  );

}