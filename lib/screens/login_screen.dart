
import 'package:flutter/material.dart';
import 'package:luxury/widgets/widgets.dart';

class LoginScreen extends StatelessWidget{
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 250),

              CardContainer(
               child: Column(
                 children: [
                   SizedBox(height: 10),
                   Text('Login', style: Theme.of(context).textTheme.headlineMedium,),
                   SizedBox(height: 30),
                 ],

               ),
              ),
            ],
          ),
        )
      ),


    );
  }

}