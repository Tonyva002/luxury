import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:luxury/services/services.dart';
import '../providers/login_form_provider.dart';
import '../ui/input_decorations.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Registro'),
        ),
        body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ChangeNotifierProvider(
                create: (_) => LoginFormProvider(),
                child: _LoginForm(),  // Llamada al formulario
              ),
            )
        )
    );
  }
}


//Clase privada para el formulario
class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    final Map<String, String> formValues = {
      'first_name': '',
      'last_name': '',
      'user': '',
      'phone': '',
      'email': '',
      'password': '',

    };

    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            //Componente del nombre el usuario
            InputDecorations.authTextFormField(
                labelText: 'Nombre',
                hintText: 'Nombre del usuario',
                formProperty: 'first_name',
                formValues: formValues,
            prefixIcon: Icons.supervised_user_circle_rounded),

            // Espacio entre los componentes
            const SizedBox(height: 30),

            //Componente del apellido del usuario
            InputDecorations.authTextFormField(
                labelText: 'Apellido',
                hintText: 'Apellido del usuario',
                formProperty: 'last_name',
                formValues: formValues,
            prefixIcon: Icons.supervised_user_circle),

            // Espacio entre los componentes
            const SizedBox(height: 30),

            //Componente del telefono del usuario
            InputDecorations.authTextFormField(
                labelText: 'Telefono',
                hintText: 'Telefono del usuario',
                formProperty: 'phone',
                formValues: formValues,
            prefixIcon: Icons.phone),

            // Espacio entre los componentes
            const SizedBox(height: 30),

            //Componente del usuario
            InputDecorations.authTextFormField(
                labelText: 'Usuario',
                hintText: 'Usuario',
                obscureText: true,
                formProperty: 'user',
                formValues: formValues,
                prefixIcon: Icons.supervised_user_circle_outlined),

            // Espacio entre los componentes
            const SizedBox(height: 30),

            //Componente del correo del usuario
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration2(
                  hintText: 't...do@gmail.com',
                  labelText: 'Correo electronico',
                  prefixIcon: Icons.alternate_email_rounded),
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = new RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'Agregue un correo valido';
              },
            ),

            // Espacio entre los componentes
            const SizedBox(height: 30),

            //Componente de la contraseña del usuario
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration2(
                  hintText: '***....',
                  labelText: 'Contraseña',
                  prefixIcon: Icons.lock_outline),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'La contraseña debe ser de 6 o mas caracteres';
              },
            ),

            // Espacio entre los componentes
            const SizedBox(height: 30),

            // Si se registro correctamente navegar a la pantalla de home, de lo contrario muestra un mensaje de usuario ya existe
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.deepPurple,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: Text(
                    loginForm.isLoading ? 'Espere...' : 'Guardar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: loginForm.isLoading
                    ? null
                    : () async {
                  FocusScope.of(context).unfocus();
                  final authService = Provider.of<AuthService>(context, listen: false);

                  if (!loginForm.isValidForm()) return;

                  loginForm.isLoading = true;

                  //TODO validar si el login es correcto
                  final String? errorMessage = await authService.createrUser(loginForm.email, loginForm.password);

                  if(errorMessage == null){
                    Navigator.pushReplacementNamed(context, 'home');
                  } else {
                    NotificationsService.showSnackbar('Usuario ya existe');
                    loginForm.isLoading = false;
                  }

                }
                ),

            // Espacio entre los componentes
            const SizedBox(height: 30),

           // Si ya tienes cuenta puedes volver al login
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(StadiumBorder())
              ),
              child: const Text(
                'Ya tienes una cuenta?',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}


