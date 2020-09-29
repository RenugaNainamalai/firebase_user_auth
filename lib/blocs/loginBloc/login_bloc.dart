import 'package:firebase_user_auth/blocs/loginBloc/login_event.dart';
import 'package:firebase_user_auth/blocs/loginBloc/login_state.dart';
import 'package:firebase_user_auth/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepository;

  LoginBloc({@required UserRepository userRepository}) {
    this.userRepository = userRepository;
  }

  @override
  LoginState get initialState => LoginInitialState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoadingState();
      try {
        var user = await userRepository.signInEmailAndPassword(
            event.email, event.password);
        yield LoginSuccessState(user);
      } catch (e) {
        yield LoginFailState(e.toString());
      }
    }
  }
}