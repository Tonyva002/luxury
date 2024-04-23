import 'package:flutter/material.dart';
import 'package:luxury/router/routes.dart';
import 'package:luxury/services/auth_service.dart';
import 'package:luxury/services/services.dart';
import 'package:luxury/theme/theme.dart';
import 'package:provider/provider.dart';

void main() {
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
    return MaterialApp(
      title: 'Luxury',                         // Titulo de la App
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initialRoute,   // Ruta iniciar de la App
      routes: AppRoutes.getAppRoutes(),       // Rutas de la App
      theme: AppTheme.lightTheme,             // Tema de la App
      scaffoldMessengerKey: NotificationsService.messengerKey,   // Mensaje de la App

    );
  }
}
