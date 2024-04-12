import 'package:flutter/material.dart';
import 'package:luxury/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Registro'),
        ),
        body: const SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Form(
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      CustomInputField(
                        labelText: 'Correo',
                        hintText: 'Correo del usuario',
                        emailAddress: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 30),
                      CustomInputField(
                        labelText: 'Contraseña',
                        hintText: 'Contraseña del usuario',
                        obscureText: true,
                      ),
                      SizedBox(height: 30),
                      CustomInputField(
                        labelText: 'Usuario',
                        hintText: 'Usuario',
                        obscureText: true,
                      ),
                      SizedBox(height: 30),
                      CustomInputField(
                          labelText: 'Nombre', hintText: 'Nombre del usuario'),
                      SizedBox(height: 30),
                      CustomInputField(
                          labelText: 'Apellido',
                          hintText: 'Apellido del usuario'),
                      SizedBox(height: 30),
                      CustomInputField(
                        labelText: 'Telefono',
                        hintText: 'Telefono del usuario',
                        obscureText: true,
                      ),
                      SizedBox(height: 30),

                      CustomButton(buttonText: "Guardar",),
                      SizedBox(height: 30),

                    ],
                  ),
                ))));
  }
}
