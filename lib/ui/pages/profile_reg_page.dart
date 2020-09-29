import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_user_auth/blocs/loginBloc/login_bloc.dart';
import 'package:firebase_user_auth/blocs/loginBloc/login_event.dart';
import 'package:firebase_user_auth/repositories/user_repository.dart';
import 'package:firebase_user_auth/ui/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class ProfileRegPage extends StatefulWidget {
    UserRepository userRepository;
  ProfileRegPage({@required this.userRepository});
 
  @override
  ProfileRegState createState() => new ProfileRegState();
 
}
class ProfileRegState extends State<ProfileRegPage> {
    File _image;
    LoginBloc loginBloc;
DateTime selectDate = DateTime.now();

  TextEditingController nameCntrlr = TextEditingController();
  TextEditingController emailCntrlr = TextEditingController();
  TextEditingController dobCntrlr = TextEditingController();
  TextEditingController genterCntrlr = TextEditingController();
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

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          centerTitle: true,
        ),
       // backgroundColor: Colors.blue[300],
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Container(
                    decoration: const BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(400))
                    ),
                    child: _image == null
                ? Text('Profile Image')
                : Image.file(_image),
                  ) 

                ),
                RaisedButton(
                  onPressed: (){
                   getGallery();
                  },
                padding: const EdgeInsets.all(0),

                  child: Container(
                   padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Row(children: <Widget>[
                      Text('Select picture',
                      style: TextStyle(fontSize: 15)),
                    ],)
                  ),
                  ),
                SizedBox(
                  height: 20.0,
                  width: 200,
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                Container(
                     height: 50,
                padding: EdgeInsets.all(10.0),
                child:TextField(
            style: new TextStyle(
              fontSize: 10,
             ),
                  controller: nameCntrlr,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Name",
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                    ),
                Container(
                  height: 45,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  style: new TextStyle(
                    fontSize: 10,
                  ),
                  controller: emailCntrlr,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Email",
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                  ),
                  Container(
                  height: 45,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  style: new TextStyle(
                    fontSize: 10,
                  ),
                  controller: dobCntrlr,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "dob",
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                  ),
                  Container(
                  height: 45,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  style: new TextStyle(
                    fontSize: 10,
                  ),
                  controller: genterCntrlr,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "gender",
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                  ),
                  Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: RaisedButton(
                      color: Colors.indigoAccent,
                      child: Text("Sign Up"),
                      textColor: Colors.white,
                      onPressed: () {
                       Firestore.instance.collection("Profile").add({
                          //"img": Image.file(_image),
                          "name": nameCntrlr.text,
                          "email": emailCntrlr.text,
                          "dob": dobCntrlr.text,
                          "gender": genterCntrlr.text,
                        });
                        navigateToLoginPage(context);
                      },
                    ),
                  ),
                  Container(
                    child: RaisedButton(
                      color: Colors.indigo,
                      child: Text("Goto Login"),
                      textColor: Colors.white,
                      onPressed: () {
                      navigateToLoginPage(context);

                      },
                    ),
                  ),
                ],
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void navigateToLoginPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
     return ProfileRegPage();
    }));
  }
}