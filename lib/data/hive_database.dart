import 'package:hive/hive.dart';
import 'package:luxury/models/file.dart';



class HiveDatabase {
  // reference our hive box
  final _myBox = Hive.box('file_database');

  // load notes
  List<Files> loadFiles() {
    List<Files> saveFilesFormatted = [];

    // if there exit notes, return that, otherwise return empty list
    if (_myBox.get("ALL_NOTES") != null) {
      List<dynamic> savedFiles = _myBox.get("ALL_NOTES");
      for (int i = 0; i < savedFiles.length; i++) {
        Files individualFile = Files(
            id: savedFiles[i][0],
            tag: savedFiles[i][1],
            text: savedFiles[i][2],
            blockId: savedFiles[i][3]);
        // add to list
        saveFilesFormatted.add(individualFile);
      }
    }

    return saveFilesFormatted;
  }

  // save notes
  void saveFiles(List<Files> allFiles) {
    List<List<dynamic>> allFilesFormatted = [
      /*
      [
        [ id1, tag1, text1 ],
        [ id2, tag2, text2 ],
      ]
      */
    ];
    // each file has and id, tag, text and blockId
    for (var file in allFiles) {
      allFilesFormatted.add([file.id, file.tag, file.text, file.blockId]);
    }

    // then, store into hive
    _myBox.put("ALL_NOTES", allFilesFormatted);

  }
}
