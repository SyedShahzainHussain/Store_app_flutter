import 'package:bloc/bloc.dart';
import 'package:store/bloc/fetch_user/fetch_user_event.dart';
import 'package:store/bloc/fetch_user/fetch_user_state.dart';
import 'package:store/data/repositories/user/user_repository.dart';

class FetchUserBloc extends Bloc<FetchUserEvent, FetchUserState> {
  UserRepository userRepository = UserRepository();
  FetchUserBloc() : super(FetchUserInitial()) {
    on<FetchUser>(_fetchUser);
  }
  _fetchUser(FetchUser event, Emitter<FetchUserState> emit) async {
    try {
      final user = await userRepository.fetchUserDetails();
      emit(FetchUserLoaded(user));
    } catch (e) {
      FetchUserError(e.toString());
    }
  }
}
