import 'package:firebase_user_auth/blocs/homeBloc/home_page_event.dart';
import 'package:firebase_user_auth/blocs/homeBloc/home_page_state.dart';
import 'package:firebase_user_auth/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
UserRepository userRepository;

  HomePageBloc({@required UserRepository userRepository}) {
    this.userRepository = userRepository;
  }

  @override
  HomePageState get initialState => LogOutInitial();

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    if (event is LogOutEvent) {
      print("LOG out Bloc");
      userRepository.signOut();
      yield LogOutSuccessState();
    }
  }

}