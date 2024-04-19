import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/favourite/favourite_event.dart';
import 'package:store/bloc/favourite/favourite_state.dart';
import 'package:store/data/repositories/categories/categories_repository.dart';
import 'package:store/data/status/status.dart';
import 'package:store/utils/global_context/context_utils.dart';
import 'package:store/utils/local_storage/storage_utility.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  CategoriesRepository categoriesRepository = CategoriesRepository();
  FavouriteBloc() : super(const FavouriteState()) {
    on<GetAllFavourite>(_getFavourite);
    on<ToggleFavourite>(_toggleFavourite);
    on<GetFavourite>(_getFavourites);
  }

  _getFavourite(GetAllFavourite event, Emitter<FavouriteState> emit) {
    try {
      final json = LocalStorage.instance().readData("favourite");
      if (json != null) {
        emit(state.copyWith(favourite: json));
      }
    } catch (_) {}
  }

  _toggleFavourite(ToggleFavourite event, Emitter<FavouriteState> emit) async {
    final Map<String, bool> favourite = Map.from(state.favourite);

    if (!favourite.containsKey(event.productId)) {
      favourite[event.productId] = true;
      await LocalStorage.instance().saveData("favourite", favourite);
    } else {
      favourite.remove(event.productId);
      await LocalStorage.instance().saveData("favourite", favourite);
    }
    if (ContextUtility.context.mounted) {
      ContextUtility.context.read<FavouriteBloc>().add(GetFavourite());
    }
    emit(state.copyWith(favourite: favourite));
  }

  _getFavourites(GetFavourite event, Emitter<FavouriteState> emit) async {
    try {
      if (state.favourite.keys.toList().isNotEmpty) {
        final favouriteProducts = await categoriesRepository
            .getFavouriteProducts(state.favourite.keys.toList());
        emit(state.copyWith(
            whishListProducts: List.from(favouriteProducts),
            status: Status.success));
      } else {
        emit(state.copyWith(whishListProducts: [], status: Status.success));
      }
    } catch (e) {
      emit(state.copyWith(message: e.toString(), status: Status.failure));
    }
  }
}
