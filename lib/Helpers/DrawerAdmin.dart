
import 'package:clinicachain/Bloc/Auth/auth_bloc.dart';
import 'package:clinicachain/Screens/Widgets/TextChain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerAdmineMenu
{

  ClipRRect drawerAdminMenu ( BuildContext context, String name, String email, DrawerSeccions menu){
    
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
              Text('ADMIN', style: GoogleFonts.getFont('Roboto', fontSize: 22, color: Colors.grey[300])),
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
          item(1 ,'Inicio', Icons.dashboard_rounded, widget.menu == DrawerSeccions.homeAdmin ? true : false, context, widget.menu),
          item(2 ,'Medicos', Icons.person_outline_rounded, widget.menu == DrawerSeccions.addMedico ? true : false, context, widget.menu),
          item(3 ,'Especialidades', Icons.format_list_bulleted_outlined, widget.menu == DrawerSeccions.especialidadesAdmin ? true : false, context, widget.menu),
          item(4 ,'Terminos', Icons.gavel_outlined, widget.menu == DrawerSeccions.terminosAdmin ? true : false, context, widget.menu),
          item(5 ,'Acerca De', Icons.help_outline_outlined, widget.menu == DrawerSeccions.acercaAdmin ? true : false, context, widget.menu),
          item(6 ,'Salir', Icons.power_settings_new_rounded, widget.menu == DrawerSeccions.salir ? true : false, context, widget.menu),
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
                      menu = DrawerSeccions.homeAdmin;
                      break;
                case 2: 
                      Navigator.pushReplacementNamed(context, 'addMedico');
                      menu = DrawerSeccions.addMedico;
                      break;
                case 3:
                      Navigator.pushReplacementNamed(context, 'especialidadesPage');
                      menu = DrawerSeccions.especialidadesAdmin;
                      break;
                case 4:
                      Navigator.pushReplacementNamed(context, 'terminosPage');
                      menu = DrawerSeccions.terminosAdmin;
                      break;
                case 5:
                      Navigator.pushReplacementNamed(context, 'acercaDePage');
                      menu = DrawerSeccions.acercaAdmin;
                      break;
                case 6:
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
              TextChain(text: 'Frave Developer',  fontSize: 16)
            ],
          ),
        ),
      ),
    );
  }
}



enum DrawerSeccions{
  // Admin
  homeAdmin,
  especialidadesAdmin,
  terminosAdmin,
  acercaAdmin,
  addMedico,
  // Paciente
  homePaciente,
  grupoFamiliarPaciente,
  misCitasPaciente,
  buscarEspecialidadPaciente,
  terminosPaciente,
  acercaPaciente,
  historiaClinicaPaciente,
  // Medico
  homeMedico,
  datosGeneralesMedico,
  serviciosMedico,
  calendarioMedico,
  citasMedico,
  resenasMedico,
  terminosMedico,
  acercaMedico,
  // Out
  home,
  acerca,
  terminos,
  salir
}