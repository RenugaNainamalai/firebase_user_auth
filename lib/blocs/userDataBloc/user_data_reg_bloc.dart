import 'dart:async';
import 'package:firebase_user_auth/blocs/userDataBloc/user_data_reg_event.dart';
import 'package:firebase_user_auth/blocs/userDataBloc/user_data_reg_state.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_user_auth/ui/pages/user_reg_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:firebase_user_auth/repositories/user_repository.dart';

class UserDataRegBloc extends Bloc<UserDataRegEvent, UserDataRegState> {

UserRepository userRepository;

UserDataRegBloc({@required UserRepository userRepository}) {
  this.userRepository = userRepository;
}
  @override
  UserDataRegState get initialState => throw UnimplementedError();

  @override
  Stream<UserDataRegState> mapEventToState(UserDataRegEvent event) {
    throw UnimplementedError();
  }
}

// class RegBloc implements BlocBase {
// RegBloc() {
//   db.init().listen((data) => _inFirestore.add(data));
// }
// String id;

// final _idController = BehaviorSubject<String>();

// Stream<String> get outId => _idController.stream;
// Sink<String> get _inId => _idController.sink;

// final _firestoreController = BehaviorSubject<QuerySnapshot>();
// Stream<QuerySnapshot> get outFirestore => _firestoreController.stream;
// Sink<QuerySnapshot> get _inFirestore => _firestoreController.sink;

// void readData() async {
//   db.readData(id);
// }

// void createData(String name, String email, String profileImg, String dob, String gender) async {

// String id = await db.createData(name, email, profileImg, dob, gender);
// this.id = id;
// _inId.add(this.id);
// }
//   @override
//   void dispose() {
//     _firestoreController.close();
//     _idController.close();
//   }

// }