import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_user_auth/blocs/regBloc/user_reg_bloc.dart';
import 'package:firebase_user_auth/blocs/regBloc/user_reg_event.dart';
import 'package:firebase_user_auth/blocs/regBloc/user_reg_state.dart';
import 'package:firebase_user_auth/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'package:meta/meta.dart';

class SignUpPageParent extends StatelessWidget {

  UserRepository userRepository;
  

  SignUpPageParent({@required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserRegBloc(userRepository: userRepository),
      child: SignUpPage(userRepository: userRepository),
    );
  }
}

class SignUpPage extends StatelessWidget {
  TextEditingController emailCntrl = TextEditingController();
  TextEditingController passCntrlr = TextEditingController();
  String authResult;
  UserRegBloc userRegBloc;
  UserRepository userRepository;
  SignUpPage({@required this.userRepository});
//setState(() { _myState = newValue;});
DateTime selectDate = DateTime.now();
TextEditingController _date = new TextEditingController();


// Future<Null> _selectDate(BuildContext context) async {
//   final DateTime picked = await showDatePicker(
//     context: context,
//      initialDate: selectDate,
//       firstDate: DateTime(1901, 1), 
//       lastDate: DateTime(2100));
//       @protected
//       void setState(VoidCallback fn){
//       if (picked != null && picked != selectDate)
//       setState(() {
//       selectDate = picked;
//       _date.value = TextEditingValue(text: picked.toString());
//       });
//       else {
//         fn();
//       }
//       }
      
// }


  @override
  Widget build(BuildContext context) {
    
    userRegBloc = BlocProvider.of<UserRegBloc>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sign Up"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(child: 
          Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(1.0),
                child: BlocListener<UserRegBloc, UserRegState>(
                  listener: (context, state) {
                    if (state is UserRegSuccessful) {
                      navigateToHomePage(context, state.user);
                    }
                  },
                  child: BlocBuilder<UserRegBloc, UserRegState>(
                    builder: (context, state) {
                      if (state is UserRegInitial) {
                        return buildInitialUi();
                      } else if (state is UserRegLoading) {
                        return buildLoadingUi();
                      } else if (state is UserRegFailure) {
                        return buildFailureUi(state.message);
                      } else if (state is UserRegSuccessful) {
                        emailCntrl.text = "";
                        passCntrlr.text = "";
                        return Container();
                      }
                    },
                  ),
                ),
              ),
              Container(
                height: 45,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  style: new TextStyle(
                    fontSize: 10,
                  ),
                  controller: emailCntrl,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "E-mail",
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
                  controller: passCntrlr,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Password",
                  ),
                  keyboardType: TextInputType.visiblePassword,
                ),
              ),
              // Container(
              //   child: GestureDetector(
              //     onTap: () => _selectDate(context),
              //     child: AbsorbPointer(
              //       child: TextFormField(
              //         controller: _date,
              //         keyboardType: TextInputType.datetime,
              //         decoration: InputDecoration(
              //           hintText: 'Date of Birth',
              //           prefixIcon: Icon(
              //            Icons.dialpad,
              //           ),
              //         ),
              //       )
              //     ),
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: RaisedButton(
                      color: Colors.indigoAccent,
                      child: Text("Sign Up"),
                      textColor: Colors.white,
                      onPressed: () {
                        Firestore.instance.collection("SignUp").add({
                          "email": emailCntrl.text,
                          "password": passCntrlr.text,
                        });
                        userRegBloc.add(SignUpButtonPressed(
                            email: emailCntrl.text, password: passCntrlr.text));
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

  Widget buildInitialUi() {
    return Text("Waiting For Authentication");
  }

  Widget buildLoadingUi() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  void navigateToHomePage(BuildContext context, FirebaseUser user) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomePageParent(user: user, userRepository: userRepository);
    }));
  }

  Widget buildFailureUi(String message) {
    return Text(
      message,
      style: TextStyle(color: Colors.red),
    );
  }


  void navigateToLoginPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LoginScreen(userRepository: userRepository);
    }));
  }
}
