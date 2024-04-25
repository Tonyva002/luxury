import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:luxury/services/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _FilesAppState();


}


class _FilesAppState extends State<HomeScreen>{

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


 /* void uploadFileToTangle(String filePath) async {
    // Leer el archivo
    List<int> fileBytes = File(filePath).readAsBytesSync();

    // Convertir los bytes del archivo en una cadena para almacenarlos en una transacción IOTA
    String fileData = fileBytes.toString();

    // Inicializar la conexión a un nodo de la red Tangle
    final iota = Iota(provider: 'https://nodes.iota.org:443');

    // Crear una transacción con los datos del archivo
    final transaction = await iota.composeTransaction(
      outputs: [
        TransferOutput(
          address: IotaAddress.random(),
          value: 0,
          message: fileData,
        )
      ],
    );

    // Enviar la transacción a la red Tangle
    final response = await iota.sendTrytes(transaction: transaction);

    // Manejar la respuesta (por ejemplo, imprimir la transacción)
    print('Transacción enviada: ${response.success}');
  }*/


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
      body: Container(child: Column(
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

      ),
      ),

    );
  }

}

