
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luxury/screens/editing_file_screen.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'package:luxury/services/services.dart';
import '../models/models.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();


}


class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<FileData>(context, listen: false).initializeList();
  }

  // create a new file
  void createNewFile() {
    // create a blank file
    var uuid = const Uuid();
    String id = uuid.v4();
    String tag = '';
    String text = '';
    String blockId = '';
    File newFile = File(id: id, tag: tag, text: text, blockId: blockId);

    // Navigate to edit the file
    goToFileScreen(newFile, true);
  }

  // method to navigate to file editing
  void goToFileScreen(File file, bool isNewFile) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditingFileScreen(file: file, isNewFile: isNewFile),
      ),
    );
  }

  // delete file
  void deleteFile(File file) {
    Provider.of<FileData>(context, listen: false).deleteFile(file);
  }

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);

    return Consumer<FileData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          leading: IconButton(
            icon: Icon(Icons.login_outlined),
            onPressed: (){
              authService.logout(); // Sign off
              Navigator.pushReplacementNamed(context, 'login');

            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewFile,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //heading
              const Padding(
                padding: EdgeInsets.only(left: 38.0, top: 25),
                child: Text(
                  'My Files',
                  style: TextStyle(fontSize: 22),
                ),
              ),

              // file list
              value.getAllFiles().isEmpty
                  ? const Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Center(
                  child: Text(
                    'Nothing here...',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              )
                  : CupertinoListSection.insetGrouped(
                backgroundColor: Colors.transparent,
                children: List.generate(
                  value.getAllFiles().length,
                      (index) => CupertinoListTile(
                    title: Text(value.getAllFiles()[index].text),
                    subtitle: Text(value.getAllFiles()[index].tag),
                    //additionalInfo: Text(value.getAllNotes()[index].tag),
                    onTap: () =>
                        goToFileScreen(value.getAllFiles()[index], false),
                    trailing: IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: () => {
                        goToFileScreen(value.getAllFiles()[index], false)
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/*class _FilesAppState extends State<HomeScreen>{

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

}*/

