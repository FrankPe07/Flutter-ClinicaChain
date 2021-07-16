
import 'package:clinicachain/Bloc/Auth/auth_bloc.dart';
import 'package:clinicachain/Helpers/DrawerAdmin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerPacienteMenu
{

  ClipRRect drawerPacienteMenu ( BuildContext context, String name, String email, DrawerSeccions menu){
    
    return ClipRRect(
      borderRadius: BorderRadius.only(topRight: Radius.circular(25), bottomRight: Radius.circular(25)),
      child: Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              HeaderDrawer(name: name, email: email),
              Divider(),
              ItemList(menu: menu),
              Divider(),
              _CopyRight()
            ],
          ),
        ),
      ),
    );

  }

}



class HeaderDrawer extends StatelessWidget {

  final String name;
  final String email;

  const HeaderDrawer({this.name, this.email});

  @override
  Widget build(BuildContext context)
  {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      height: 170,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Color(0xff306FFD),
                radius: 25,
                child: Text( '${name.substring(0, 1)}', style: GoogleFonts.getFont('Roboto', fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              Text('PACIENTE', style: GoogleFonts.getFont('Roboto', fontSize: 22, color: Colors.grey[300])),
            ],
          ),
          SizedBox(height: 10),
          Text( name , style: GoogleFonts.getFont('Roboto', fontSize: 22)),
          SizedBox(height: 1),
          Text( email, style: GoogleFonts.getFont('Roboto', fontSize: 17, color: Colors.grey[400])),
        ],
      ),
    );
  }
}


class ItemList extends StatefulWidget {

  final DrawerSeccions menu;

  const ItemList({this.menu});

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) 
  {
    return Container(
      child: Column(
        children: [
          item(1 ,'Inicio', Icons.dashboard_rounded, widget.menu == DrawerSeccions.homePaciente ? true : false, context, widget.menu),
          item(2 ,'Grupo Familiar', Icons.supervised_user_circle_outlined, widget.menu == DrawerSeccions.grupoFamiliarPaciente ? true : false, context, widget.menu),
          item(3 ,'Mis Citas', Icons.event_note_outlined, widget.menu == DrawerSeccions.misCitasPaciente ? true : false, context, widget.menu),
          item(4 ,'Buscar Especialidad', Icons.search, widget.menu == DrawerSeccions.buscarEspecialidadPaciente ? true : false, context, widget.menu),
          item(5 ,'Historia Clinica', Icons.list_alt_rounded, widget.menu == DrawerSeccions.historiaClinicaPaciente ? true : false, context, widget.menu),
          item(6 ,'Terminos', Icons.gavel_outlined, widget.menu == DrawerSeccions.terminosPaciente ? true : false, context, widget.menu),
          item(7 ,'Acerca De', Icons.help_outline_outlined, widget.menu == DrawerSeccions.acercaPaciente ? true : false, context, widget.menu),
          item(8 ,'Salir', Icons.power_settings_new_rounded, widget.menu == DrawerSeccions.salir ? true : false, context, widget.menu),
        ],
      ),
    );
  }

  Widget item(int id, String text, IconData icon, bool selected, BuildContext context, DrawerSeccions menu){

    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      height: 52,
      child: Material(
        color: selected ? Color(0xff2B57C0).withOpacity(0.1) : Colors.transparent,
        child: InkWell(
          onTap: (){

              switch (id) {
                case 1: 
                      Navigator.pushReplacementNamed(context, 'homePage');
                      menu = DrawerSeccions.homePaciente;
                      break;
                case 2:
                      Navigator.pushReplacementNamed(context, 'grupoFamiliarPage');
                      menu = DrawerSeccions.grupoFamiliarPaciente;
                      break;
                case 3:
                      Navigator.pushReplacementNamed(context, 'misCitasPage');
                      menu = DrawerSeccions.misCitasPaciente;
                      break;
                case 4:
                      Navigator.pushReplacementNamed(context, 'buscarEspecialidadPage');
                      menu = DrawerSeccions.buscarEspecialidadPaciente;
                      break;
                case 5:
                      Navigator.pushReplacementNamed(context, 'historiaClinicaPaciente');
                      menu = DrawerSeccions.historiaClinicaPaciente;
                      break;
                case 6:
                      Navigator.pushReplacementNamed(context, 'terminosPage');
                      menu = DrawerSeccions.terminosPaciente;
                      break;
                case 7:
                      Navigator.pushReplacementNamed(context, 'acercaDePage');
                      menu = DrawerSeccions.acercaPaciente;
                      break;
                case 8:
                      menu = DrawerSeccions.salir;
                      authBloc.add( LogOutEvent() );
                      setState(() {});
                      break;

                default:
                      break;
              }    

          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Expanded(
                  child: Icon(icon, size: 34, color: selected ? Color(0xff2B57C0) : Colors.black87),
                ),
                Expanded(
                  flex: 3,
                  child: Text( text , style: GoogleFonts.getFont('Roboto', fontSize: 17, color: selected ? Color(0xff2B57C0) : Colors.black87))
                )
              ],
            ),
          ),
        )
      ),
    );
  } 
}


class _CopyRight extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(bottom: 20.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.copyright_outlined),
              SizedBox(width: 5),
              Text('Frave Developer', style: GoogleFonts.getFont('Roboto', fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
