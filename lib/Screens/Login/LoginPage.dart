import 'package:clinicachain/Screens/Login/RegisterPacientePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinicachain/Screens/Widgets/TextChain.dart';
import 'package:clinicachain/Screens/Widgets/TextFieldCustom.dart';
import 'package:clinicachain/Bloc/Auth/auth_bloc.dart';
import 'package:clinicachain/Screens/Home/HomePage.dart';
import 'package:clinicachain/Screens/Widgets/ModalAlert.dart';
import 'package:clinicachain/Screens/Widgets/BtnCustom.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> 
{

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    final size = MediaQuery.of(context).size;
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        
        if( state.authModels != null && state is AuthState ){

          Navigator.of(context).pop();
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
        
        } else if ( state is LoadingState ){

          loadingDialog(context); 

        }else if ( state is FailureState ){

          Navigator.of(context).pop();
          print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
          print(state.error);
          ScaffoldMessenger.of(context).showSnackBar( SnackBar(
            content: TextChain(text: 'Las credenciales introducidas son incorrectas', fontSize: 18, color: Colors.white ),
            backgroundColor: Colors.red,
          ));

        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  TextChain(text: 'BIENVENIDO A', fontSize: 35, fontWeight: FontWeight.bold),
                  TextChain(text: 'CLINICA CHAIN', fontSize: 45, fontWeight: FontWeight.bold, color: Color(0xff1A60C1)),
                  TextChain(text: 'Inicia sesión para continuar', fontSize: 21, color: Colors.grey),
                  SizedBox(height: 35),

                  _AccountSocial(account: 'Usar cuenta Facebook', image: 'facebook.png'),
                  _AccountSocial(account: 'Usar cuenta Google', image: 'googleIcon.png'),

                  SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 1,
                        width: size.width * 0.4,
                        color: Colors.grey[200],
                      ),
                      TextChain(text: ' Or '),
                      Container(
                        height: 1,
                        width: size.width * 0.4,
                        color: Colors.grey[200],
                      ),
                    ],
                  ),

                  SizedBox(height: 25),
                  TextChain(text: 'Correo Electronico', fontSize: 19, color: Colors.black),
                  SizedBox(height: 5),
                  TextFieldCustomChain(controller: emailController, fillColor: Color(0xffEFF3F6), hint: 'email@example.com', type: TextInputType.emailAddress ),
                  SizedBox(height: 15),
                  TextChain(text: 'Contraseña', fontSize: 19, color: Colors.black),
                  SizedBox(height: 5),
                  TextFieldCustomChain(controller: passwordController, fillColor: Color(0xffEFF3F6), hint: '*********', obscureText: true ),

                  SizedBox(height: 35),
                  BtnCustom(
                    borderRadius: 20,
                    text: 'Iniciar sesión', 
                    onPressed: () => authBloc.add( LoginEvent(email: emailController.text, password: passwordController.text)),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextChain(text: 'No tienes una cuenta? ', fontSize: 17, color: Colors.black54),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => RegisterPacientePage())),
                        child: TextChain(text: ' Registrate', fontSize: 17, color: Color(0xff1A60C1))
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}



class _AccountSocial extends StatelessWidget {
  
  final String account;
  final String image;

  const _AccountSocial({this.account, this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 25.0),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.grey[200], blurRadius: 15,)
          ]
        ),
        child: TextButton(
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('Assets/$image', height: 25),
              SizedBox(width: 15),
              TextChain(text: this.account, fontSize: 18),
            ],
          ),
        ),
      ),
    );
  }
}