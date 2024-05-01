
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luxury/screens/file_screen.dart';
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
    Files newFile = Files(id: id, tag: tag, text: text, blockId: blockId);

    // Navigate to edit the file
    goToFileScreen(newFile, true);
  }

  // method to navigate to file editing
  void goToFileScreen(Files file, bool isNewFile) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditingFileScreen(file: file, isNewFile: isNewFile),
      ),
    );
  }

  // delete file
  void deleteFile(Files file) {
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


