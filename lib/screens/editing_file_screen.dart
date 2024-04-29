import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


import '../models/models.dart';
import '../ui/input_decorations.dart';

class EditingFileScreen extends StatefulWidget {
  File file;
  bool isNewFile;

  EditingFileScreen({super.key, required this.file, required this.isNewFile});

  @override
  State<EditingFileScreen> createState() => _EditingFileScreenState();
}

class _EditingFileScreenState extends State<EditingFileScreen> {
    final _formKey = GlobalKey<FormBuilderState>();


  // add new file
  void handleFile(String tag, String text) {
    // add the new file
    // with a fake blockId until iota-client is in place
    Provider.of<FileData>(context, listen: false).addNewFile(File(
        id: widget.file.id,
        tag: tag,
        text: text,
        blockId:
            '0x036a28765f3609f33c4a37b1bf17a67afb6393c04fac48e9c0f3f97885fedaff'));
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
        title: widget.isNewFile
            ? const Text('Add Tagged Data Block')
            : const Text('Info'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child:FormBuilder(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),

                if (widget.isNewFile)
                  FormBuilderTextField(
                    name: 'text',
                    validator: FormBuilderValidators.minLength(4),
                    initialValue: widget.file.text,
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
                    initialValue: widget.file.text,
                    decoration: const InputDecoration(
                      hintText: 'Insert a new text message',
                      filled: true,
                      fillColor: Colors.white,
                      label: Text('Text'),
                    ),
                  ),
                const SizedBox(height: 20),
                if (widget.isNewFile)
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
                if (widget.isNewFile)
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
                      child: Text(
                        'Send to Tangle',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}


