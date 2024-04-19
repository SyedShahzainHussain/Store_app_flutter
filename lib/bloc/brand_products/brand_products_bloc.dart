import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/brand_products/brand_products_event.dart';
import 'package:store/bloc/brand_products/brand_products_state.dart';
import 'package:store/data/repositories/categories/categories_repository.dart';
import 'package:store/data/status/status.dart';
import 'package:store/features/shop/model/product_model/product_model.dart';

class BrandProductsBloc extends Bloc<BrandProducts, BrandProductsState> {
  CategoriesRepository categoriesRepository = CategoriesRepository();
  BrandProductsBloc() : super(const BrandProductsState()) {
    on<GetSpecificBrandProducts>(_getSpecificBrandProducts);
  }
  // ! get product of specific brand
  Future<void> _getSpecificBrandProducts(
      GetSpecificBrandProducts event, Emitter<BrandProductsState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final List<ProductModel> brandProducts = await categoriesRepository
          .getProductForBrand(brandId: event.brandId, limit: event.limit!);

      emit(state.copyWith(
        brandProducts: brandProducts,
        status: Status.success,
        message: "Successfully fetch brand products",
      ));
    } catch (e) {
      emit(state.copyWith(message: e.toString(), status: Status.failure));
    }
  }
}
