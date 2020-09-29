import 'package:equatable/equatable.dart';


abstract class UserDataRegEvent extends Equatable {}

class RegisterButtonPressed extends UserDataRegEvent {
  String name, email, profileImg, dob, gender;

  RegisterButtonPressed({this.name, this.email, this.dob, this.gender, this.profileImg});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  
}