import 'package:bloc/bloc.dart';
import 'package:store/bloc/fetch_categories/fetch_categories_event.dart';
import 'package:store/bloc/fetch_categories/fetch_categories_state.dart';
import 'package:store/data/repositories/categories/categories_repository.dart';
import 'package:store/data/status/status.dart';
import 'package:store/features/shop/model/categories_model/categories_model.dart';

class FetchCategoriesBloc
    extends Bloc<FetchCategoriesEvents, FetchCategoriesState> {
  List<CategoryModel> categoriesList = [];
  List<CategoryModel> featuresCategories = [];

  CategoriesRepository categoriesRepository = CategoriesRepository();
  FetchCategoriesBloc() : super(const FetchCategoriesState()) {
    on<GetCategoriesEvent>(_getCategoryEvent);
  }
  _getCategoryEvent(
      GetCategoriesEvent event, Emitter<FetchCategoriesState> emit) async {
    try {
      // ! get all categories
      categoriesList = await categoriesRepository.getAllCategories();
      // ! get features categories only 8 
      featuresCategories = categoriesList
          .where((e) => e.isFeatured && e.parentId.isEmpty)
          .take(8)
          .toList();

      emit(
        state.copyWith(
            categoriesList: List.from(categoriesList),
            featuresCategories: List.from(featuresCategories),
            status: Status.success,
            message: "Categories Fetch Successfully"),
      );
    } catch (e) {
      emit(
        state.copyWith(status: Status.failure, message: e.toString(),categoriesList: [],featuresCategories: []),
      );
    }
  }
}
