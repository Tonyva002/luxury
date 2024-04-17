import 'package:flutter/material.dart';
import 'package:luxury/services/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);

   return Scaffold(
     appBar: AppBar(
       title: Text('Home'),
       leading: IconButton(
         icon: Icon(Icons.login_outlined),
         onPressed: (){
           authService.logout();
           Navigator.pushReplacementNamed(context, 'login');

         },
       ),
     ),
     body: Container(
       child: Column(
         children: [
           Text('Home Screen', style: TextStyle(fontSize: 25),)
         ],
       ),

     ),
   );
  }

}