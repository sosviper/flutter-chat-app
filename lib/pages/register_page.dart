import 'dart:ffi';

import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:chat/widgets/logo.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/custom_boton.dart';
import 'package:chat/widgets/labels.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Logo( titulo: 'Registro',),

                _Form(),

                Labels( 
                  ruta: 'login', 
                  titulo: '¿Ya tienes una cuenta?', 
                  subtitulo: 'Ingresa ahora',
                ),

                Text('Terminos y condiciones de uso', style: TextStyle( fontWeight: FontWeight.w200 ),),


              ],
            ),
          ),
        ),
      ),
    );
  }
}


class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  final nombreCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: EdgeInsets.only( top: 40 ),
      padding: EdgeInsets.symmetric( horizontal: 50 ),
      child: Column(
        children: <Widget>[

          CustomInput(
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            keyboardType: TextInputType.text,
            textController: nombreCtrl,
          ),

          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),

          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),
          
          CustomBoton(
            text: 'Crear cuenta',
            color: Colors.green,
            onPressed: authService.autenticando ? nullptr : () async {
              print( nombreCtrl);
              print( emailCtrl);
              print( passCtrl);
              final registerOk = await authService.register(nombreCtrl.text.trim(), emailCtrl.text.trim(), passCtrl.text.trim());

              if ( registerOk == true ) {
                // TODO: Conectar socket server
                Navigator.pushReplacementNamed(context, 'usuarios') ;
              } else {
                mostrarAlerta(context, 'Registro incorrecto', registerOk);
              }

            },
          ),

        ],
      ),
    );
  }
}
