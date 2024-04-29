import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'package:luxury/router/routes.dart';
import 'package:luxury/services/services.dart';
import 'package:luxury/theme/theme.dart';


import 'models/models.dart';

void main() async {

  //initialize hive
  await Hive.initFlutter();

  // open a hive box
  await Hive.openBox('file_database');

  runApp( AppState());

}


class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return MultiProvider(
       providers: [
         ChangeNotifierProvider(create: ( _ ) => AuthService()),
         
       ],
     child: MyApp(),
   );
  }
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => FileData(),
      builder: (context, child) => MaterialApp(
        title: 'Luxury',                         // Titulo de la App
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.initialRoute,   // Ruta iniciar de la App
        routes: AppRoutes.getAppRoutes(),       // Rutas de la App
        theme: AppTheme.lightTheme,             // Tema de la App
        scaffoldMessengerKey: NotificationsService.messengerKey,   // Mensaje de la App

      ),
    );
  }
}
