
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/fetch_products/fetch_products_event.dart';
import 'package:store/bloc/fetch_products/fetch_products_state.dart';
import 'package:store/data/repositories/categories/categories_repository.dart';
import 'package:store/data/status/status.dart';
import 'package:store/features/shop/model/product_model/product_model.dart';

class FetchProductsBloc extends Bloc<FetchProductsEvents, FetchProductsState> {
  CategoriesRepository categoriesRepository = CategoriesRepository();
  List<ProductModel> productList = [];
  FetchProductsBloc() : super(const FetchProductsState()) {
    on<GetProductsEvent>(_getProductEvent);
  }

  _getProductEvent(
      GetProductsEvent event, Emitter<FetchProductsState> emit) async {
    try {
      productList = await categoriesRepository.getAllProducts();
      emit(state.copyWith(
        message: "Products Fetch Successfully",
        products: List.from(productList),
        status: Status.success,
      ));
    } catch (e) {
      emit(state.copyWith(
          message: e.toString(), products: [], status: Status.failure));
    }
  }
}
