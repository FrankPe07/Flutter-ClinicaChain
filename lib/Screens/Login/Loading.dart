import 'package:clinicachain/Bloc/Auth/auth_bloc.dart';
import 'package:clinicachain/Screens/Home/HomePage.dart';
import 'package:clinicachain/Screens/Login/LoginPage.dart';
import 'package:clinicachain/Screens/Widgets/Load.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingLoginPage extends StatelessWidget
{

 @override
 Widget build(BuildContext context)
 {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
            
        if( state is LoggedInState ){
          
          Navigator.of(context).push(MaterialPageRoute(builder: ( context ) => HomePage()));
          
        }
        else if ( state is LoggedOutState ){
          Navigator.of(context).push(MaterialPageRoute(builder: ( context ) => LoginPage()));
          
        }

      },
      child: Material(
        child: Load()
      ),
    );
  }
}

