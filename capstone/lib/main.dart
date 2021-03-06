import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Capstone Design II'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              print('Import Video from Gallery');
              addVideoFromGallery();
            },
            child: button(context, 'Import Video from Gallery'),
          ),
          InkWell(
            onTap: () {
              print('Import Video from Camera');
              addVideoFromCamera();
            },
            child: button(context, 'Import Video from Camera'),
          ),
        ],
      ),
    );
  }

  Widget button(BuildContext context, String title) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
      child: Center(
        child: Text('$title'),
      ),
    );
  }

  void addVideoFromGallery() async {
    List<Media> res = await ImagesPicker.pick(
      pickType: PickType.all,
      language: Language.System,
      // cropOpt: CropOption(
      //   aspectRatio: CropAspectRatio.wh16x9,
      // ),
      // maxTime: 60,
    );
    if (res != null) {
      print(res.map((e) => e.path).toList());
      setState(() {
        path = res[0].thumbPath;
      });
    }
  }

  void addVideoFromCamera() async {
    List<Media> res = await ImagesPicker.openCamera(
      pickType: PickType.image,
      quality: 0.5,
      // cropOpt: CropOption(
      //   aspectRatio: CropAspectRatio.wh16x9,
      // ),
      // maxTime: 60,
    );
    if (res != null) {
      print(res[0].path);
      setState(() {
        path = res[0].thumbPath;
      });
    }
  }
}
