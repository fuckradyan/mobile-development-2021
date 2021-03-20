import 'dart:io';
import 'dart:typed_data';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';

class PreviewScreen extends StatefulWidget {
  final String imgPath;
  final String fileName;
  PreviewScreen({this.imgPath, this.fileName});

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Image.file(
                  File(widget.imgPath),
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      color: Colors.black,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.file_download,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              getBytes().then((bytes) {
                                print('here now');
                                print(widget.imgPath);
                              });
                              final params = SaveFileDialogParams(
                                  sourceFilePath: widget.imgPath);
                              final filePath = await FlutterFileDialog.saveFile(
                                  params: params);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.share_outlined,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              getBytes().then((bytes) {
                                print('here now');
                                print(widget.imgPath);
                                print(bytes.buffer.asUint8List());
                                Share.file('Share via', widget.fileName,
                                    bytes.buffer.asUint8List(), 'image/path');
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ));
  }

  Future getBytes() async {
    Uint8List bytes = File(widget.imgPath).readAsBytesSync() as Uint8List;
//    print(ByteData.view(buffer))
    return ByteData.view(bytes.buffer);
  }
}
