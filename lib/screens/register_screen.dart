import 'package:flutter/material.dart';
import 'package:luxury/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../providers/login_form_provider.dart';
import '../ui/input_decorations.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
   /* final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();

    final Map<String, String> formValues = {
      'first_name': '',
      'last_name': '',
      'user': '',
      'phone': '',
      'email': '',
      'password': '',

    };*/

    return Scaffold(
        appBar: AppBar(
          title: Text('Registro'),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child:   ChangeNotifierProvider(
                  create: (_) => LoginFormProvider(),
                  child: _LoginForm(),
                ),
    )
    )
    );

         /*       Form(
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

                             MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.deepPurple,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: Text('Guardar',style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: loginForm.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();
                        if (!loginForm.isValidForm()) return;
                        loginForm.isLoading = true;

                        await Future.delayed(Duration(seconds: 2));

                        //TODO validar si el login es correcto
                        loginForm.isLoading = false;

                        Navigator.pushReplacementNamed(context, 'home');
                      })



                      const SizedBox(height: 30),

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
                ))));*/
  }
}

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
                labelText: 'Usuario',
                hintText: 'Usuario',
                obscureText: true,
                formProperty: 'user',
                formValues: formValues),
            const SizedBox(height: 30),


            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration2(
                  hintText: 'tony.do@gmail.com',
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
            const SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration2(
                  hintText: '*****',
                  labelText: 'Contraseña',
                  prefixIcon: Icons.lock_outline),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'La contraseña debe ser de 6 o mas caracteres';
              },
            ),
            const SizedBox(height: 30),
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
                  if (!loginForm.isValidForm()) return;
                  loginForm.isLoading = true;

                  await Future.delayed(Duration(seconds: 2));

                  //TODO validar si el login es correcto
                  loginForm.isLoading = false;

                  Navigator.pushReplacementNamed(context, 'home');
                }
                ),

            const SizedBox(height: 30),

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


