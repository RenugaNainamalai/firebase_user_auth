import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserDataRegState extends Equatable {}

class UserDataRegInitial extends UserDataRegState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}
class UserDataRegLoading extends UserDataRegState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}

class UserDataRegSuccessful  extends UserDataRegState {
  FirebaseUser userData;
  UserDataRegSuccessful(this.userData);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}
class UserDataRegFailure extends UserDataRegState {

String message;
UserDataRegFailure(this.message);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}