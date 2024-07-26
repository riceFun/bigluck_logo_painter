import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart' show getApplicationDocumentsDirectory

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CaptureWidget(child: const LogoBox()),
    );
  }
}

class LogoBox extends StatefulWidget {
  const LogoBox({super.key});

  @override
  State<LogoBox> createState() => _LogoBoxState();
}

class _LogoBoxState extends State<LogoBox> {
  static const double kSize = 800;
  static const double offset = 80;
  final double kWidth = kSize - offset;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Container(
          height: kSize,
          width: kSize,
          color: Colors.red,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Expanded(
                flex: 2,
                child: SizedBox(),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.amber,
                  child: LayoutBuilder(
                    builder: (context, cons) {
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Stack(
                          children: [
                            Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  width: cons.maxWidth - offset,
                                  height: cons.maxHeight - offset,
                                  color: Colors.lightGreen,
                                )),
                            Positioned(
                                left: 0,
                                bottom: 0,
                                child: Container(
                                  width: cons.maxWidth - offset,
                                  height: cons.maxHeight - offset,
                                  color: Colors.lightBlue,
                                )),
                            const Positioned.fill(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'BigLuck大吉',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 110,
                                    color: Colors.yellowAccent,
                                    fontWeight: FontWeight.w900,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black,
                                        offset: Offset(20.0, 20.0),
                                        blurRadius: 10.0,
                                      ),
                                      // 可以添加多个阴影以创建复杂的效果
                                    ],
                                  ),
                                )
                              ],
                            ))
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              const Expanded(
                flex: 2,
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CaptureWidget extends StatefulWidget {
  final Widget child;
  const CaptureWidget({super.key, required this.child});

  @override
  State<CaptureWidget> createState() => _CaptureWidgetState();
}

class _CaptureWidgetState extends State<CaptureWidget> {
  GlobalKey _repaintKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _repaintKey,
      child: GestureDetector(
          onTap: () {
            _toUIImage();
          },
          child: widget.child),
    );
  }

  Future<ui.Image?> _toUIImage() async {
    BuildContext? buildContext = _repaintKey.currentContext;
    if (buildContext != null) {
      RenderRepaintBoundary boundary =
          buildContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 1.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      _downloadImage(pngBytes);
      return image;
    }
    return null;
  }
}

//下载图片到  本机-下载文件夹/flt_card
_downloadImage(Uint8List imageData) async {
  print('==============》下载');
  MimeType type = MimeType.jpeg;
  FileSaver.instance.saveFile(name: 'BigLuck_Logo',filePath: '/Users/xiuji-1tb/Desktop/project', mimeType: type);

  // String path;
  // if (name != null) {
  //
  //
  //   path = await FileSaver.instance
  //       .saveFile('flt_card', imageData, "png", mimeType: type);
  // } else {
  //   path = await FileSaver.instance.saveFile(
  //       'flt_card/captrue/截图${DateTime.now().toString()}', imageData, "png",
  //       mimeType: type);
  // }
  // print(path);
}

// class CaptureWidget extends StatefulWidget {
//   final Widget child;
//
//   const
//   @override
//   _CaptureWidgetState createState() => _CaptureWidgetState();
// }
//
// class _CaptureWidgetState extends State<CaptureWidget> {
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return RepaintBoundary(
//       key: _repaintKey,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text('Hello, Flutter!', style: TextStyle(fontSize: 24),),
//           ElevatedButton(
//             onPressed: _captureWidgetAndSave,
//             child: Text('Capture Widget'),
//           ),
//         ],
//       ),
//     );
//   }
// }
