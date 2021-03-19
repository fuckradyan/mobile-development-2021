import 'package:flutter/material.dart';
import 'package:flutter_application_1/lab/lab2/screens/camera.dart';
import 'package:path/path.dart';
import 'chewie_list_item.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(LabSecond());
}

class LabSecond extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomePage();
  }
}

class MyHomePage extends State {
  bool radioVal;
  @override
  void initState() {
    radioVal = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //     child: Column(
    //   children: [
    //     ChewieListItem(
    //         videoPlayerController: VideoPlayerController.network(
    //       'https://samplelib.com/lib/preview/mp4/sample-20s.mp4',
    //     )),
    //   ],
    // ));
    // Expanded(child: CameraScreen());

    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(children: [
                  OutlineButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Scaffold(
                                  appBar: AppBar(
                                    title: Text("Просмотр видео"),
                                  ),
                                  body: Column(
                                    children: [
                                      ChewieListItem(
                                        videoPlayerController:
                                            VideoPlayerController.network(
                                          'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
                                        ),
                                      ),
                                      ChewieListItem(
                                        videoPlayerController:
                                            VideoPlayerController.network(
                                          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
                                        ),
                                      ),
                                    ],
                                  ))));
                    },
                    child: Text(
                      'Открыть видео',
                    ),
                  ),
                ]),
                Column(
                  children: [
                    OutlineButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Scaffold(
                                    // appBar: AppBar(
                                    //   title: Text("Камера"),
                                    // ),
                                    body: CameraScreen())));
                      },
                      child: Text(
                        'Открыть камеру',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
