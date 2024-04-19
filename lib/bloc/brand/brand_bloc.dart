import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/brand/brand_event.dart';
import 'package:store/bloc/brand/brand_state.dart';
import 'package:store/data/repositories/categories/categories_repository.dart';
import 'package:store/data/status/status.dart';
import 'package:store/features/shop/model/brand_model/brand_model.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  CategoriesRepository categoriesRepository = CategoriesRepository();
  BrandBloc() : super(const BrandState()) {
    on<GetBrand>(_getBrand);
  }

  // ! get brand only 4 who isFeatured is true
  _getBrand(GetBrand event, Emitter<BrandState> emit) async {
    try {
      final List<BrandModel> brand = await categoriesRepository.getAllBrands();
      final List<BrandModel> featuredBrand = brand
          .where((element) => element.isFeatured ?? false)
          .take(3)
          .toList();
      emit(state.copyWith(
          allBrand: List.from(brand),
          featuredBrand: List.from(featuredBrand),
          status: Status.success,
          message: "Fetch Brand Success"));
    } catch (e) {
      emit(state.copyWith(message: e.toString(), status: Status.failure));
    }
  }

  
}
