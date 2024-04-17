import 'package:flutter/material.dart';
import 'package:luxury/screens/home_screen.dart';
import 'package:luxury/screens/screen.dart';
import '../models/models.dart';


class AppRoutes {
  static const initialRoute = "checking";

  static final menuOptions = <MenuOption>[
    MenuOption(route: "checking", name: "Check auth", screen: CheckAuthScreen(), icon: Icons.supervised_user_circle_outlined),
    MenuOption(route: "login", name: "Login", screen: const LoginScreen(), icon: Icons.supervised_user_circle_outlined),
    MenuOption(route: "register", name: "Register", screen: const RegisterScreen(), icon: Icons.app_registration_outlined),
    MenuOption(route: "home", name: "Home", screen: const HomeScreen(), icon: Icons.home_sharp)

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