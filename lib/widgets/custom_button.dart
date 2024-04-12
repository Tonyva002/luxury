
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? buttonText;
  final IconData? icon;
  const CustomButton({super.key, this.buttonText, this.icon});
  @override
  Widget build(BuildContext context) {
    final Map<String, String> formValues = {
      'first_name': 'Tony',
      'last_name': 'Vasquez',
      'email': 'tonyva002@hotmail.com',
      'password': '123456',
      'role': 'Admin'
    };
    return  ElevatedButton(
      child: SizedBox(
        child: Center(child: Text('$buttonText')),
        width: double.infinity,
      ),
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(
            Size.fromHeight(50)), // Altura deseada del botón
      ),
      onPressed: () {
        print(formValues);
      },
    );
  }
}
