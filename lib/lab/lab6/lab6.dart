import 'package:flutter/material.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'dart:io';
import 'package:aes_crypt/aes_crypt.dart';
import '../../main.dart';

void main() => runApp(LabSixth());

class LabSixth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Encrypt/Decrypt';

    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: MyCustomForm(),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    MyFirstApp.analytics.logEvent(name: 'lab6_opened', parameters: null);
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  @override
  void initState() {
    super.initState();
    dec = '';
  }

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final controllerOne = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String dec;
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: controllerOne,
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState.validate()) {
                      if (controllerOne.text.length > 6 &&
                          controllerOne.text.length < 32) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        final path = await FlutterDocumentPicker.openDocument()
                            .then((value) {
                          print(value);
                          dec = decrypt_file(value);
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Слишком маленький ключ')));
                      }
                    }
                  },
                  child: Text('Расшифровать'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (controllerOne.text.length > 6 &&
                        controllerOne.text.length < 32) {
                      final path = await FlutterDocumentPicker.openDocument()
                          .then((value) {
                        encrypt_file(value);
                        print(value);
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Неверный ключ')));
                    }

                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                  },
                  child: Text('Зашифровать'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  String encrypt_file(String path) {
    if (path != null) {
      print(path);
      AesCrypt crypt = AesCrypt();
      crypt.setOverwriteMode(AesCryptOwMode.on);
      crypt.setPassword(controllerOne.text);

      String encFilepath;
      try {
        encFilepath = crypt.encryptFileSync(
            path, '/storage/emulated/0/Download/enc_file.aes');
        print(encFilepath);
        print('The encryption has been completed successfully.');
        print('Encrypted file: $encFilepath');
      } catch (e) {
        if (e.type == AesCryptExceptionType.destFileExists) {
          print('The encryption has been completed unsuccessfully.');
          print(e.message);
        } else {
          return 'ERROR';
        }
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('File encrypted')));
      return encFilepath;
    }
  }

  String decrypt_file(String path) {
    AesCrypt crypt = AesCrypt();
    crypt.setOverwriteMode(AesCryptOwMode.on);
    crypt.setPassword(controllerOne.text);
    String decFilepath;
    String dec;
    try {
      decFilepath = crypt.decryptFileSync(path);
      print('The decryption has been completed successfully.');
      print('Decrypted file 1: $decFilepath');
      print('File content: ' + File(decFilepath).path);

      File(decFilepath).readAsString().then((String contents) {
        print(contents);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Scaffold(body: Center(child: Text('$contents')))));
        return contents;
      });
    } catch (e) {
      if (e.type == AesCryptExceptionType.destFileExists) {
        print('The decryption has been completed unsuccessfully.');
        print(e.message);
      } else {
        return 'ERROR';
      }
    }
    return dec;
  }
}
