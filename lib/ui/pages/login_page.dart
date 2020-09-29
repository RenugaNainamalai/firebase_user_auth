import 'package:firebase_user_auth/blocs/loginBloc/login_bloc.dart';
import 'package:firebase_user_auth/blocs/loginBloc/login_event.dart';
import 'package:firebase_user_auth/blocs/loginBloc/login_state.dart';
import 'package:firebase_user_auth/repositories/user_repository.dart';
import 'package:firebase_user_auth/ui/pages/home_page.dart';
import 'package:firebase_user_auth/ui/pages/profile_reg_page.dart';
import 'package:firebase_user_auth/ui/pages/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_user_auth/ui/pages/user_reg_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';        
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatelessWidget {
  UserRepository userRepository;

  LoginScreen({@required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(userRepository: userRepository),
      child: LoginPage(userRepository: userRepository),
    );
  }
}

class LoginPage extends StatelessWidget {
  TextEditingController emailCntrlr = TextEditingController();
  TextEditingController passCntrlr = TextEditingController();
  LoginBloc loginBloc;
  UserRepository userRepository;

  LoginPage({@required this.userRepository});

  @override
  Widget build(BuildContext context) {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("User Login"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: 
         Container(
         padding: EdgeInsets.all(3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccessState) {
                      navigateToHomeScreen(context, state.user);
                    }
                  },
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if (state is LoginInitialState) {
                        return buildInitialUi();
                      } else if (state is LoginLoadingState) {
                        return buildLoadingUi();
                      } else if (state is LoginFailState) {
                        return buildFailureUi(state.message);
                      } else if (state is LoginSuccessState) {
                        emailCntrlr.text = "";
                        passCntrlr.text = "";
                        return Container();
                      }
                    },
                  ),
                ),
              ),
             Container(
               height: 50,
                padding: EdgeInsets.all(10.0),
                child:TextField(
            style: new TextStyle(
              fontSize: 10,
             ),
                  controller: emailCntrlr,
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
                height: 50,
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
                )
              ),
              Container(
                height: 100,
        
                padding: EdgeInsets.all(10.0),
                child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: RaisedButton(
                      color: Colors.indigoAccent,
                      child: Text("Login"),
                      textColor: Colors.white,
                      
                      onPressed: () {
                        Firestore.instance.collection("Login").add({
                          "email": emailCntrlr.text,
                          "password": passCntrlr.text,
                        });
                        loginBloc.add(
                          LoginButtonPressed(
                            email: emailCntrlr.text,
                            password: passCntrlr.text,
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    child: RaisedButton(
                      color: Colors.indigo,
                      child: Text("Sign Up Now"),
                      textColor: Colors.white,
                      onPressed: () {
                        navigateToSignUpScreen(context);
                      },
                    ),
                  ),                
                  
                ],
              ),
              ),
              Column(
children: <Widget>[
  Container(
    height: 50,
     padding: EdgeInsets.fromLTRB(0, 10, 125, 10),
     child: RaisedButton(
      child: Text("Register"),
      onPressed: () { 
       navigateToRegisterData(context);
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
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Text(
        "Login",
        style: TextStyle(
          fontSize: 25.0,
          color: Colors.indigo,
          height: 1,
        ),
      ),
      
    );
  }

  Widget buildLoadingUi() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildFailureUi(String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(5.0),
          child: Text(
            "Fail $message",
            style: TextStyle(color: Colors.red),
          ),
        ),
        buildInitialUi(),
      ],
    );
  }

  void navigateToHomeScreen(BuildContext context, FirebaseUser user) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return HomePageParent(user: user, userRepository: userRepository);
    }));
  }

  void navigateToSignUpScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SignUpPageParent(userRepository: userRepository);
    }));
  }
Future navigateToRegisterData(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileRegPage()));
}
 
 
}
