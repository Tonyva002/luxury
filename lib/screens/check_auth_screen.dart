
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:luxury/screens/screen.dart';
import 'package:luxury/services/services.dart';
import 'package:provider/provider.dart';

/*class CheckAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthSBervice>(context);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: authService.readToken(),
            builder: (BuildContext contex, AsyncSnapshot<String> snapshot){

              if( !snapshot.hasData)
                return Text('');

            if( snapshot.data == ''){
              Future.microtask(() {
                Navigator.pushReplacement(context, PageRouteBuilder(
                    pageBuilder: (_,__,___) => LoginScreen(),
                    transitionDuration: Duration(seconds: 0)
                )
                );

              });
            }else{

              Future.microtask(() {
                Navigator.pushReplacement(context, PageRouteBuilder(
                    pageBuilder: (_,__,___) => HomeScreen(),
                    transitionDuration: Duration(seconds: 0)
                )
                );

              });

            }

              return Container();
            },
            ),
      ),

    );
  }

}*/