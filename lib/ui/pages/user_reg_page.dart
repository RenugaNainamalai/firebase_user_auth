
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerData extends StatefulWidget {
  List Data;
  int ITId;
  ImagePickerData({this.Data, this.ITId});
  @override
  AttachmentState createState() => new AttachmentState();
}

class AttachmentState extends State<ImagePickerData> {
  File _image;

  @override
  Widget build(BuildContext context) {
    Future getCamera() async {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      setState(() {
        _image = image;
      });
    }

    Future getGallery() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
      });
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 190.0,
          width: 190.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: _image == null
                ? Text('Profile Image')
                : Image.file(_image),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: Row(
                  //mainAxisSize: MainAxisSize.max,
                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                        elevation: 4.0,
                        onPressed: () {
                          getGallery();
                        },
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(10.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.indigo,
                                borderRadius:
                                BorderRadius.all(Radius.circular(80.0))),
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text('Camera',
                                    style: TextStyle(fontSize: 15)),
                              ],
                            ))),
                    RaisedButton(
                      elevation: 4.0,
                      onPressed: () {
                        getGallery();
                      },
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      child: Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[
                                  Color(0xFFf7418c),
                                  Color(0xFFfbab66),
                                ],
                              ),
                              borderRadius:
                              BorderRadius.all(Radius.circular(80.0))),
                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text('Take Picture',
                              style: TextStyle(fontSize: 15)),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}



//import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
//import 'dart:io';
//
//
//class RegisterData extends StatefulWidget {
//
//RegisterData() : super();
//final String title = "User Data Register";
//
//  @override
//  _RegUserDataState createState() => _RegUserDataState();
//
//  }
//  class  _RegUserDataState extends State<RegisterData> {
//    Future<File> imageFile;
//    picImageFromGallery(ImageSource source){
//      setState(() {
//        imageFile = ImagePicker.pickImage(source: source);
//      });
//    }
//Widget showImage() {
//    return FutureBuilder<File>(
//      future: imageFile,
//      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
//        if (snapshot.connectionState == ConnectionState.done &&
//            snapshot.data != null) {
//          return Image.file(
//            snapshot.data,
//            width: 50,
//            height: 50,
//          );
//        } else if (snapshot.error != null) {
//          return const Text(
//            'Error Picking Image',
//            textAlign: TextAlign.center,
//          );
//        } else {
//          return const Text(
//            'No Image Selected',
//            textAlign: TextAlign.center,
//          );
//        }
//      },
//    );
//  }
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
//      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            showImage(),
//            RaisedButton(
//              child: Text("Select Image from Gallery"),
//              onPressed: () {
//                picImageFromGallery(ImageSource.gallery);
//              },
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//
//  }
