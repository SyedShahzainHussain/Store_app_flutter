import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/fetch_user/fetch_user_bloc.dart';
import 'package:store/bloc/fetch_user/fetch_user_event.dart';
import 'package:store/bloc/upload_image/upload_image_event.dart';
import 'package:store/bloc/upload_image/upload_image_state.dart';
import 'package:store/data/repositories/user/user_repository.dart';
import 'package:store/utils/global_context/context_utils.dart';
import 'package:store/utils/network/network_manager.dart';
import 'package:store/utils/popups/full_screen_loader.dart';

class UploadImageBloc extends Bloc<UploadImageEvent, UploadImageState> {
  UserRepository userRepository = UserRepository();
  UploadImageBloc() : super(UploadImageInitial()) {
    on<UploadImage>(_uploadImage);
  }
  _uploadImage(UploadImage event, Emitter<UploadImageState> emit) async {
    try {
      emit(UploadImageLoading());
      final isConnected = await NetworkManager().isConnected();
      // ! if no network then show error and stop the other other code
      if (!isConnected) {
        emit(UploadImageError(
            "Network Error! Please check your internet connection."));
        TFullScreenLoader.stopLoading();
        return;
      }
      final imageUrl = await userRepository.uploadImage(
          "Users/Images/Profile/", event.image!);
      // ! Update User Image Record
      Map<String, dynamic> json = {"profilePicture": imageUrl};
      await userRepository.updateSingleField(json);
      if (ContextUtility.context.mounted) {
        BlocProvider.of<FetchUserBloc>(ContextUtility.context).add(FetchUser());
      }
      TFullScreenLoader.stopLoading();
      emit(UploadImageSuccess());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      emit(UploadImageError(e.toString()));
    }
  }
}
