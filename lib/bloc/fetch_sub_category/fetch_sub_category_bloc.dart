import 'package:bloc/bloc.dart';
import 'package:store/bloc/fetch_sub_category/fetch_sub_category_event.dart';
import 'package:store/bloc/fetch_sub_category/fetch_sub_category_state.dart';
import 'package:store/data/repositories/categories/categories_repository.dart';
import 'package:store/data/status/status.dart';
import 'package:store/features/shop/model/categories_model/categories_model.dart';

class FetchSubCategoryBloc
    extends Bloc<FetchSubCategoryEvent, FetchSubCategoryState> {
  CategoriesRepository categoriesRepository = CategoriesRepository();
  FetchSubCategoryBloc() : super(const FetchSubCategoryState()) {
    on<FetchSubCategory>(_fetchSubCategory);
  }
  Future<void> _fetchSubCategory(
      FetchSubCategory event, Emitter<FetchSubCategoryState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      List<CategoryModel> subCategoryList =
          await categoriesRepository.getSubCategory(event.categoryId);

      emit(state.copyWith(
        message: "Data Fetch SubCategory",
        status: Status.success,
        subCategoryList: List.from(subCategoryList),
      ));
    } catch (e) {
      emit(state.copyWith(
        message: e.toString(),
        status: Status.failure,
      ));
    }
  }
}
