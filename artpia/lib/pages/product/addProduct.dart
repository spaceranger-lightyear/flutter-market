import 'dart:async';
import 'package:artpia/assets/config.dart';
import 'package:artpia/assets/modules.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage>
    with AutomaticKeepAliveClientMixin<AddProductPage> {
  bool get wantKeepAlive => true;

  final TextEditingController _titleTextEditController =
      TextEditingController();
  final TextEditingController _descriptionTextEditController =
      TextEditingController();
  final TextEditingController _priceTextEditController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int price;
  int likes;
  String category;

  List<String> imageURL = [];
  List<String> tags = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            productImages(context),
            productField(context),
            uploadButton(context),
          ],
        ),
      ),
    );
  }

  Widget productImages(BuildContext context) {
    List<Widget> imageList = [emptyImageBox(context)];

    return Container(
      height: 118,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        scrollDirection: Axis.horizontal,
        children: imageList,
      ),
    );
  }

  Widget emptyImageBox(BuildContext context) {
    const double _length = 92;

    return Material(
      child: InkWell(
        onTap: () {
        },
        child: Container(
          margin: EdgeInsets.only(right: 15),
          width: _length,
          height: _length,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: Colors.white,
          ),
          child: Center(
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  Widget imageBox(BuildContext context) {
    const double _length = 92;

    return Material(
      child: InkWell(
        child: Container(
          margin: EdgeInsets.only(right: 15),
          width: _length,
          height: _length,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget productField(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [],
      ),
    );
  }

  Widget uploadButton(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          setState(() {});

          showDialog(
              context: context,
              builder: (BuildContext context) {
                Future.delayed(Duration(seconds: 2), () {});
                return AlertDialog(
                  content: Text('선택된 이미지가 없습니다!'),
                );
              });
        },
        child: InkWell(
          onTap: () {
            addProduct(Artpia.sharedPreferences.getString('uid'));
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: MediaQuery.of(context).size.width * (335 / 375),
            height: 44,
            color: Colors.black,
            child: Center(
              child: Text(
                '등록하기',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future addProduct(String uid) async {
    Firestore.instance.collection("product").document(uid).setData({
      'uid': uid,
      'pid': uid + DateTime.now().microsecondsSinceEpoch.toString(),
      'title': _titleTextEditController.text.trim(),
      'description': _descriptionTextEditController.text.trim(),
      'price': _priceTextEditController.text.trim(),
      'likes': '0',
      // 'imageURL': userImgUrl,
      'tags': List<String>(),
      Artpia.userCartList: ['init'],
    });
  }

  Future uploadImages(int index) async {
    showDialog(
      context: context,
      builder: (c) {
        return LoadingAlertDialog(message: 'Adding images, Please wait.');
      },
    );

    // String imgFileName = DateTime.now().millisecondsSinceEpoch.toString();
    // StorageReference storageReference =
    //     FirebaseStorage.instance.ref().child(imgFileName);
    // ByteData byteData = await asset.getByteData(quality: 100);
    // List<int> imgData = byteData.buffer.asUint8List();
    // StorageUploadTask storageUploadTask = storageReference.putData(imgData);
    // StorageTaskSnapshot storageTaskSnapshot =
    //     await storageUploadTask.onComplete;
    // await storageTaskSnapshot.ref.getDownloadURL().then((imgUrl) {
    //   imageURL[index] = imgUrl;
    // });
  }

//
// Widget productTags(BuildContext context) {
//   List<Widget> tagList = [ emptyTagBox(context)];
//
//   if (_tags?.isEmpty ?? true)
//     for (int i = 0; i < _tags.length; i++)
//       tagList.add(tagBox(context, _tags[i]));
//
//   return Container(
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           child: Text('태그 추가'),
//         ),
//         Container(
//           height: 45,
//           child: ListView(
//             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//             scrollDirection: Axis.horizontal,
//             children: tagList,
//           ),
//         ),
//       ],
//     ),
//   );
// }
//
// Future<void> loadTags() async {
//   setState(() {
//     _formKey.currentState.save();
//     if (_tags == null) _tags = List<Tag>();
//   });
//
//   String tag;
//   String _error;
//
//   try {
//     tag = await showDialog<String>(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('태그를 추가하세요.'),
//             content: TextFormField(
//               onChanged: (value) => tag = value,
//               style: TextStyle(
//                 fontSize: 12,
//               ),
//               cursorColor: primary,
//               decoration: InputDecoration(
//                   contentPadding: EdgeInsets.only(left: 10),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(0),
//                     borderSide: BorderSide(
//                       color: primary,
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(0),
//                     borderSide: BorderSide(
//                       color: primary,
//                     ),
//                   ),
//                   hintText: ''),
//             ),
//             actions: [
//               FlatButton(
//                 onPressed: () => Navigator.pop(context),
//                 color: primary,
//                 child: Text('취소'),
//               ),
//               FlatButton(
//                 onPressed: () => Navigator.pop(context, tag),
//                 color: primary,
//                 child: Text('추가'),
//               )
//             ],
//           );
//         });
//   } on Exception catch (e) {
//     _error = e.toString();
//   }
//
//   setState(() {
//     _tags.add(Tag(tag));
//     _error = _error;
//   });
// }
//
// Widget emptyTagBox(BuildContext context) {
//   const double _length = 30;
//
//   return Material(
//     child: InkWell(
//       onTap: () {
//         loadTags();
//       },
//       child: Container(
//         margin: EdgeInsets.only(left: 20),
//         width: _length,
//         height: _length,
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.black),
//           color: offWhite,
//         ),
//         child: Center(
//           child: Icon(Icons.add),
//         ),
//       ),
//     ),
//   );
// }
//
// Widget tagBox(BuildContext context, Tag tag) {
//   return Material(
//     child: InkWell(
//       child: Container(
//         margin: EdgeInsets.only(left: 10),
//         width: tag.title.length * 10 + 30.0,
//         height: 30,
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.black),
//           color: offWhite,
//         ),
//         child: Stack(
//           alignment: Alignment.topRight,
//           children: [
//             Center(
//                 child: Center(
//                   child: Text(tag.title),
//                 )),
//             Material(
//               child: InkWell(
//                 onTap: () {
//                   setState(() {
//                     _tags.remove(tag);
//                   });
//                 },
//                 child: ImageIcon(
//                   AssetImage(delete_tag_idle),
//                   size: 12,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     ),
//   );

}