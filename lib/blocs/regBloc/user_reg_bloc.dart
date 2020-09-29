import 'package:firebase_user_auth/blocs/regBloc/user_reg_event.dart';
import 'package:firebase_user_auth/blocs/regBloc/user_reg_state.dart';
import 'package:firebase_user_auth/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class UserRegBloc extends Bloc<UserRegEvent, UserRegState> {
  UserRepository userRepository;

  UserRegBloc({@required UserRepository userRepository}) {
    this.userRepository = userRepository;
  }

  @override
  UserRegState get initialState => UserRegInitial();

  @override
  Stream<UserRegState> mapEventToState(UserRegEvent event) async* {
    if (event is SignUpButtonPressed) {
      yield UserRegLoading();
      try {
        var user = await userRepository.signUpUserWithEmailPass(
            event.email, event.password);
        print("BLoC : ${user.email}");
        yield UserRegSuccessful(user);
      } catch (e) {
        yield UserRegFailure(e.toString());
      }
    }
  }
}
