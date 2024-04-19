import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/all_products/all_product_event.dart';
import 'package:store/bloc/all_products/all_product_state.dart';
import 'package:store/data/repositories/categories/categories_repository.dart';
import 'package:store/data/status/status.dart';
import 'package:store/features/shop/model/product_model/product_model.dart';

class AllProductBloc extends Bloc<AllProductsEvents, AllProductState> {
  CategoriesRepository categoriesRepository = CategoriesRepository();
  AllProductBloc() : super(const AllProductState()) {
    on<GetAllProduct>(_getAllProducts);
    on<SortProducts>(_sortProducts);
  }

  Future<void> _getAllProducts(
      GetAllProduct event, Emitter<AllProductState> emit) async {
    try {
      final List<ProductModel> products = await categoriesRepository
          .fetchProductQuery(FirebaseFirestore.instance
              .collection("Products")
              .where("IsFeatured", isEqualTo: true));

      emit(state.copyWith(
          productModel: List.from(products), 
          sortedProduct: List.from(products),
          status: Status.success,
          message: "Successfully Fetch All Products "));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }

  Future<void> _sortProducts(
      SortProducts event, Emitter<AllProductState> emit) async {
    try {
      final List<ProductModel> sortedProduct = List.from(event.productModel);
      switch (event.sortOption) {
        case "Name":
          sortedProduct.sort(
            (a, b) => a.title.compareTo(b.title),
          );
          break;
        case "Higher Price":
          sortedProduct.sort(
            (a, b) => b.price.compareTo(a.price),
          );
          break;
        case "Lower Price":
          sortedProduct.sort(
            (a, b) => a.price.compareTo(b.price),
          );
          break;
        case "Sale":
          sortedProduct.sort((a, b) {
            if (b.salePrice > 0) {
              return b.salePrice.compareTo(a.salePrice);
            } else if (a.salePrice > 0) {
              return -1;
            } else {
              return 1;
            }
          });
          break;
        case "Newest":
          sortedProduct.sort(
            (a, b) => a.time!.compareTo(b.time!),
          );
          break;
        default:
          sortedProduct.sort(
            (a, b) => a.title.compareTo(b.title),
          );
      }
      emit(state.copyWith(
        sortedProduct: List.from(sortedProduct),
        status: Status.success,
        productModel: List.from(event.productModel),
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }


 

}
