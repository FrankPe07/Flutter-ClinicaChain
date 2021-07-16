

import 'package:clinicachain/Helpers/DraweMedico.dart';
import 'package:clinicachain/Helpers/DrawerAdmin.dart';
import 'package:clinicachain/Helpers/DrawerPaciente.dart';
import 'package:flutter/cupertino.dart';

class DrawerCustom
{

  drawerCustom( String idRol, BuildContext context, String name, String email, DrawerSeccions selectedMenu ){

    if( idRol == '1' ) {

      if( selectedMenu == DrawerSeccions.acerca ){
        return DrawerAdmineMenu().drawerAdminMenu( context, name , email, DrawerSeccions.acercaAdmin );
      } else if( selectedMenu == DrawerSeccions.terminos ){
        return DrawerAdmineMenu().drawerAdminMenu( context, name , email, DrawerSeccions.terminosAdmin );
      } else if( selectedMenu == DrawerSeccions.home ){
        return DrawerAdmineMenu().drawerAdminMenu( context, name , email, DrawerSeccions.homeAdmin );
      } else {
        return DrawerAdmineMenu().drawerAdminMenu( context, name , email, selectedMenu );
      }
      
    }
    else if ( idRol == '2' ) {

      if( selectedMenu == DrawerSeccions.acerca ){
        return DrawerPacienteMenu().drawerPacienteMenu( context, name , email, DrawerSeccions.acercaPaciente );
      } else if( selectedMenu == DrawerSeccions.terminos ){
        return DrawerPacienteMenu().drawerPacienteMenu( context, name , email, DrawerSeccions.terminosPaciente );
      } else if( selectedMenu == DrawerSeccions.home ){
        return DrawerPacienteMenu().drawerPacienteMenu( context, name , email, DrawerSeccions.homePaciente );
      } else {
        return DrawerPacienteMenu().drawerPacienteMenu( context, name , email, selectedMenu );
      }

    }
    else if ( idRol == '3' ) {
      
      if( selectedMenu == DrawerSeccions.acerca ){
        return DrawerMedicoMenu().drawerMedicoMenu( context, name , email, DrawerSeccions.acercaMedico );
      } else if( selectedMenu == DrawerSeccions.terminos ){
        return DrawerMedicoMenu().drawerMedicoMenu( context, name , email, DrawerSeccions.terminosMedico );
      } else if( selectedMenu == DrawerSeccions.home ){
        return DrawerMedicoMenu().drawerMedicoMenu( context, name , email, DrawerSeccions.homeMedico );
      } else {
        return DrawerMedicoMenu().drawerMedicoMenu( context, name , email, selectedMenu );
      }

    }
  }

}