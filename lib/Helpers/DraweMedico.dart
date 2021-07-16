
import 'package:clinicachain/Bloc/Auth/auth_bloc.dart';
import 'package:clinicachain/Helpers/DrawerAdmin.dart';
import 'package:clinicachain/Screens/Widgets/TextChain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerMedicoMenu
{

  ClipRRect drawerMedicoMenu ( BuildContext context, String name, String email, DrawerSeccions menu){
    
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
      height: 150,
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
                child: TextChain(text: '${name.substring(0, 1).toUpperCase()}', fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              TextChain(text: 'MEDICO', fontSize: 22, color: Colors.grey[300]),
            ],
          ),
          SizedBox(height: 10),
          TextChain(text: name, fontSize: 22),
          SizedBox(height: 1),
          TextChain(text: email, fontSize: 17, color: Colors.grey[400]),
        ],
      ),
    );
  }
}


class ItemList extends StatelessWidget {

  final DrawerSeccions menu;

  const ItemList({this.menu});

  @override
  Widget build(BuildContext context) 
  {
    return Container(
      height: 500,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            item(1 ,'Inicio', Icons.dashboard_rounded, menu == DrawerSeccions.homeMedico ? true : false, context, menu),
            item(2 ,'Datos Generales', Icons.perm_identity_rounded, menu == DrawerSeccions.datosGeneralesMedico ? true : false, context, menu),
            item(3 ,'Servicios y precios', Icons.monetization_on_outlined, menu == DrawerSeccions.serviciosMedico ? true : false, context, menu),
            item(4 ,'Calendario', Icons.today_outlined, menu == DrawerSeccions.calendarioMedico ? true : false, context, menu),
            item(5 ,'Citas', Icons.menu_book_outlined, menu == DrawerSeccions.citasMedico ? true : false, context, menu),
            item(6 ,'Reseñas y opiniones', Icons.thumb_up_outlined, menu == DrawerSeccions.resenasMedico ? true : false, context, menu),
            item(7 ,'Terminos', Icons.gavel_outlined, menu == DrawerSeccions.terminosMedico ? true : false, context, menu),
            item(8 ,'Acerca De', Icons.help_outline_outlined, menu == DrawerSeccions.acercaMedico ? true : false, context, menu),
            item(9 ,'Salir', Icons.power_settings_new_rounded, menu == DrawerSeccions.salir ? true : false, context, menu),
          ],
        ),
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
                      menu = DrawerSeccions.homeMedico;
                      break;
                case 2:
                      Navigator.pushReplacementNamed(context, 'datosGenerales');
                      menu = DrawerSeccions.datosGeneralesMedico;
                      break;
                case 3:
                      Navigator.pushReplacementNamed(context, 'servicioPrecio');
                      menu = DrawerSeccions.serviciosMedico;
                      break;
                case 4:
                      Navigator.pushReplacementNamed(context, 'calendarioPage');
                      menu = DrawerSeccions.calendarioMedico;
                      break;
                case 5:
                      Navigator.pushReplacementNamed(context, 'citasPage');
                      menu = DrawerSeccions.citasMedico;
                      break;
                case 6:
                      Navigator.pushReplacementNamed(context, 'resenasPage');
                      menu = DrawerSeccions.resenasMedico;
                      break;
                case 7:
                      Navigator.pushReplacementNamed(context, 'terminosPage');
                      menu = DrawerSeccions.terminosMedico;
                      break;
                case 8:
                      Navigator.pushReplacementNamed(context, 'acercaDePage');
                      menu = DrawerSeccions.acercaMedico;
                      break;
                case 9:
                      authBloc.add( LogOutEvent() );
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
