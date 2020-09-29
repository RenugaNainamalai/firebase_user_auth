import 'package:firebase_user_auth/blocs/authBloc/auth_event.dart';
import 'package:firebase_user_auth/blocs/authBloc/auth_state.dart';
import 'package:firebase_user_auth/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserRepository userRepository;
  AuthBloc({@required UserRepository userRepository}) {
    this.userRepository = userRepository;
  }
  @override 

  AuthState get initialState => AuthInitialState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {

    if (event is AppStartedEvent){

    try {
      var isSignedIn = await userRepository.isSignedIn();
      if (isSignedIn){
        var user = await userRepository.getCurrentUser();
        yield AuthenticatedState(user);
      } else {
        yield UnauthenticatedState();
      }
    } catch (e) {
      yield UnauthenticatedState();
    }

    }
  }
}