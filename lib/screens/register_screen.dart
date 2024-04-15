import 'package:flutter/material.dart';
import 'package:luxury/widgets/widgets.dart';

import '../ui/input_decorations.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();

    final Map<String, String> formValues = {
      'first_name': 'Tony',
      'last_name': 'Vasquez',
      'user': 'tonyva',
      'phone': '809-342-5016',
      'email': 'tonyva002@hotmail.com',
      'password': '123456',
      'role': 'Admin'
    };

    return Scaffold(
        appBar: AppBar(
          title: Text('Registro'),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Form(
                  key: myFormKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      InputDecorations.authTextFormField(
                          labelText: 'Nombre',
                          hintText: 'Nombre del usuario',
                          formProperty: 'first_name',
                          formValues: formValues),
                      const SizedBox(height: 30),
                      InputDecorations.authTextFormField(
                          labelText: 'Apellido',
                          hintText: 'Apellido del usuario',
                          formProperty: 'last_name',
                          formValues: formValues),
                      const SizedBox(height: 30),
                      InputDecorations.authTextFormField(
                          labelText: 'Telefono',
                          hintText: 'Telefono del usuario',
                          formProperty: 'phone',
                          formValues: formValues),
                      const SizedBox(height: 30),
                      InputDecorations.authTextFormField(
                          labelText: 'Correo',
                          hintText: 'Correo del usuario',
                          emailAddress: TextInputType.emailAddress,
                          formProperty: 'email',
                          formValues: formValues),
                      const SizedBox(height: 30),
                      InputDecorations.authTextFormField(
                          labelText: 'Usuario',
                          hintText: 'Usuario',
                          obscureText: true,
                          formProperty: 'user',
                          formValues: formValues),
                      const SizedBox(height: 30),
                      InputDecorations.authTextFormField(
                          labelText: 'Contraseña',
                          hintText: 'Contraseña del usuario',
                          obscureText: true,
                          formProperty: 'password',
                          formValues: formValues),
                      const SizedBox(height: 30),
                      DropdownButtonFormField(
                          value: 'Admin',
                          items: const [
                            DropdownMenuItem(
                                value: 'Admin', child: Text('Admin')),
                            DropdownMenuItem(
                                value: 'Superuser', child: Text('Superuser')),
                            DropdownMenuItem(
                                value: 'Developer', child: Text('Developer')),
                            DropdownMenuItem(
                                value: 'Jr. Developer',
                                child: Text('Jr. Developer')),
                          ],
                          onChanged: (value) {
                            print(value);
                            formValues['role'] = value ?? 'Admin';
                          }),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                              const Size.fromHeight(50)), // Altura deseada del botón
                        ),
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());

                          if (!myFormKey.currentState!.validate()) {
                            print('Formulario no valido');
                            return;
                          }
                          print(formValues);
                        },
                        child: const SizedBox(
                          child: Center(child: Text('Guardar')),
                          width: double.infinity,
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ))));
  }
}
