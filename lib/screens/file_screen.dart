import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:luxury/models/file.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ffi.dart';
import '../models/models.dart';

class EditingFileScreen extends StatefulWidget {
  Files file;
  bool isNewFile;

  EditingFileScreen({super.key, required this.file, required this.isNewFile});

  @override
  State<EditingFileScreen> createState() => _EditingFileScreenState();
}

class _EditingFileScreenState extends State<EditingFileScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  bool mostrarTexto = true;

  FilePickerResult? result;
  String? _fileName;
  PlatformFile? pickefile;
  bool isLoading = false;
  File? fileToDisplay;

  // Add file from phone
  void addFile() async {
    try {
      setState(() {
        isLoading = true;
        mostrarTexto = false;
      });

      result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        // allowedExtensions: ['jpg','png', 'pdf'],
        allowMultiple: false,
      );
      if (result != null) {
        _fileName = result!.files.first.name;
        pickefile = result!.files.first;
        fileToDisplay = File(pickefile!.path.toString());

        print('name file $_fileName');
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }
  // add new note
 /* void handleFile(String tag, String text) {
    // add the new note
    // with a fake blockId until iota-client is in place
    Provider.of<FileData>(context, listen: false).addNewFile(Files(
        id: widget.file.id,
        tag: tag,
        text: text,
        blockId:
        '0x036a28765f3609f33c4a37b1bf17a67afb6393c04fac48e9c0f3f97885fedaff'));
    Navigator.pop(context);
  }*/
  // add new file
   Future<void> handleFile(String tag, String text) async {
    try {
      final receivedBlockId =
          await api.publishTaggedDataBlock( tag: tag, message: text);

      storeAndReturnToHomepage(tag, text, receivedBlockId);
    } on FfiException catch (e) {
      showSnackBar(e.message);
    }
  }

  void showSnackBar(String message) {
    var snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void storeAndReturnToHomepage(String tag, String text, String blockId) {
    // add the new file
    Provider.of<FileData>(context, listen: false).addNewFile(
        Files(id: widget.file.id, tag: tag, text: text, blockId: blockId));
    Navigator.pop(context);
  }

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse(
        'https://explorer.shimmer.network/shimmer/block/${widget.file.blockId}');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isNewFile ? const Text('File') : const Text('Info'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: widget.isNewFile
          ? FloatingActionButton(
              onPressed: () {
                addFile();
              },
              child: const Column(
                children: [
                  Icon(Icons.add, color: Colors.white),
                  Text('File', style: TextStyle(color: Colors.white)),
                ],
              ),
            )
          : const Text(''),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 20),
        
                  if (widget.isNewFile && pickefile == null)
                    Column(
                      children: [
                        Visibility(
                          visible: mostrarTexto,
                          child: const Center(
                              child: Text('Favor agregar un archivo',
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontSize: 32,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                      decorationStyle:
                                          TextDecorationStyle.dotted))),
                        ),
                      ],
                    ),
        
                  if (widget.isNewFile && pickefile != null)
                    FormBuilderTextField(
                      name: 'text',
                      validator: FormBuilderValidators.minLength(4),
                      //enabled: false,
                      initialValue: '$fileToDisplay',
                      decoration: const InputDecoration(
                        hintText: 'Insert a new text message',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
        
                  if (!widget.isNewFile)
                    FormBuilderTextField(
                      name: 'text',
                      validator: FormBuilderValidators.minLength(4),
                      enabled: false,
                      // initialValue: _fileName,
                      initialValue: widget.file.text,
                      decoration: const InputDecoration(
                        hintText: 'Insert a new text message',
                        filled: true,
                        fillColor: Colors.white,
                        label: Text('Text'),
                      ),
                    ),
                  const SizedBox(height: 20),
                  if (widget.isNewFile && pickefile != null)
                    FormBuilderTextField(
                      name: 'tag',
                      validator: FormBuilderValidators.minLength(4),
                      initialValue: widget.file.tag,
                      decoration: const InputDecoration(
                        hintText: 'Insert a new tag',
                      ),
                    ),
                  if (!widget.isNewFile)
                    FormBuilderTextField(
                      name: 'tag',
                      validator: FormBuilderValidators.minLength(4),
                      enabled: false,
                      initialValue: widget.file.tag,
                      decoration: const InputDecoration(
                        hintText: 'Insert a new tag',
                        label: Text('Tag'),
                      ),
                    ),
                  const SizedBox(height: 50),
                  if (widget.isNewFile && pickefile != null)
                    ElevatedButton(
                      onPressed: () {
                        bool ok = _formKey.currentState!.saveAndValidate();
                        if (ok) {
                          handleFile(_formKey.currentState?.fields['tag']?.value,
                              _formKey.currentState?.fields['text']?.value);
                        }
                        debugPrint(
                            _formKey.currentState?.instantValue.toString() ?? '');
                      },
                      style: ElevatedButton.styleFrom(
                        //  foregroundColor:
                        //  Colors.black, // Text Color (Foreground color)
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('Send to Tangle'),
                      ),
                    ),
                  if (!widget.isNewFile)
                    ElevatedButton(
                      onPressed: () {
                        _launchUrl();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('Show in Block Explorer'),
                      ),
                    ),
        
                  const SizedBox(height: 50),
        
                  //Component to upload the file
                  if (pickefile != null)
                    Center(
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              height: 300,
                              width: 400,
                              child: Image.file(fileToDisplay!)),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
