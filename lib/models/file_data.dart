import 'package:flutter/material.dart';
import 'package:luxury/data/hive_database.dart';
import 'file.dart';

class FileData extends ChangeNotifier {
  // hive database
  final db = HiveDatabase();

  // overall list of files
  List<File> allFiles = [
    //default first file
    // File(
    //     id: 'abc',
    //     tag: 'First Tag',
    //     text: 'First File lorem ipsum dolor continua et sufficum ad dolores'),
    // File(id: 'def', tag: 'Second Tag', text: 'Second File'),
  ];

  //initialize list
  void initializeList() {
    allFiles = db.loadFiles();
  }

  // get files
  List<File> getAllFiles() {
    return allFiles;
  }

  // add a new file
  void addNewFile(File file) {
    allFiles.add(file);
    db.saveFiles(allFiles);
    notifyListeners();
  }

  //update file
  void updateFile(File file, String tag, String text) {
    // go thru list of all files
    for (int i = 0; i < allFiles.length; i++) {
      if (allFiles[i].id == file.id) {
        allFiles[i].tag = tag;
        allFiles[i].text = text;
      }
    }
    db.saveFiles(allFiles);
    notifyListeners();
  }

  // delete note
  void deleteFile(File file) {
    allFiles.remove(file);
    db.saveFiles(allFiles);
    notifyListeners();
  }
}
