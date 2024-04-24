import 'dart:io';

import 'package:file_picker/file_picker.dart';
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
           authService.logout(); // Cerrar sesion
           Navigator.pushReplacementNamed(context, 'login');

         },
       ),
     ),
     body: Container(child: _FilesApp()),


   );
  }

}

class _FilesApp extends StatefulWidget {

  _FilesAppState createState() => _FilesAppState();

}

class _FilesAppState extends State<_FilesApp>{

  FilePickerResult? result;
  String? _fileName;
  PlatformFile? pickefile;
  bool isLoading = false;
  File? fileToDisplay;

  void addFile() async{
    try{
      setState(() {
        isLoading = true;
      });

      result = await FilePicker.platform.pickFiles(
        type: FileType.any,
       // allowedExtensions: ['jpg','png', 'pdf'],
        allowMultiple: false,

      );
      if(result != null){
        _fileName = result!.files.first.name;
        pickefile = result!.files.first;
        fileToDisplay = File(pickefile!.path.toString());

        print('File name $_fileName');
        print('file path $fileToDisplay');
      }

      setState(() {
        isLoading = false;
      });

    }catch(e){
      print(e);
    }

  }


  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: isLoading
              ? CircularProgressIndicator()
          : TextButton(
              onPressed: () {
                addFile();
              },
              child: Text('Add File')),
        ),
        if(pickefile != null)
          SizedBox(
            height: 300, width: 400, child: Image.file(fileToDisplay!)),
      ],

    );
  }

}

