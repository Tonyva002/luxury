import 'package:flutter/material.dart';
import 'package:luxury/screens/screen.dart';
import '../models/models.dart';


class AppRoutes {
  static const initialRoute = "login";

  static final menuOptions = <MenuOption>[
    MenuOption(route: "login", name: "Login", screen: const LoginScreen(), icon: Icons.supervised_user_circle_outlined),
    MenuOption(route: "register", name: "Register", screen: const RegisterScreen(), icon: Icons.supervised_user_circle_outlined)

  ];


  static Map<String, Widget Function(BuildContext)> getAppRoutes(){

    Map<String, Widget Function(BuildContext)> appRoutes = {};
    appRoutes.addAll({'login' : (BuildContext context) => const LoginScreen()});

    for(final option in menuOptions){
      appRoutes.addAll({option.route : (BuildContext context) => option.screen} );
    }
    return appRoutes;

  }
}