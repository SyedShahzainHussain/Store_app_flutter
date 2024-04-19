import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/fetch_user/fetch_user_event.dart';
import 'package:store/bloc/update_name/update_name_event.dart';
import 'package:store/bloc/update_name/update_name_state.dart';
import 'package:store/data/repositories/user/user_repository.dart';
import 'package:store/utils/global_context/context_utils.dart';
import 'package:store/utils/network/network_manager.dart';
import 'package:store/utils/popups/full_screen_loader.dart';

import '../fetch_user/fetch_user_bloc.dart';

class UpdateNameBloc extends Bloc<UpdateNameEvents, UpdateNameState> {
  UserRepository userRepository = UserRepository();
  UpdateNameBloc() : super(UpdateNameInitial()) {
    on<UpdateName>(_updateName);
  }

  Future<void> _updateName(
      UpdateName event, Emitter<UpdateNameState> emit) async {
    try {
      // ! Intial Loading
      emit(UpdateNameLoading());

      final isConnected = await NetworkManager().isConnected();
      // ! if no network then show error and stop the other other code
      if (!isConnected) {
        emit(UpdateNameFailed(
            "Network Error! Please check your internet connection."));
        TFullScreenLoader.stopLoading();
        return;
      }
      // ! Update the firstName and lastName in the Firebase Database
      Map<String, dynamic> name = {
        'firstName': event.firstName.trim(),
        'lastName': event.lastName.trim()
      };
      await userRepository.updateSingleField(name);

      TFullScreenLoader.stopLoading();
      if (ContextUtility.context.mounted) {
        BlocProvider.of<FetchUserBloc>(ContextUtility.context).add(FetchUser());
      }
      emit(UpdateNameSuccess());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      emit(UpdateNameFailed(e.toString()));
    }
  }
}
