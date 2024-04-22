import 'package:equatable/equatable.dart';
import 'package:store/data/status/status.dart';
import 'package:store/features/shop/model/categories_model/categories_model.dart';
import 'package:store/features/shop/model/product_model/product_model.dart';

class FetchSubCategoryState extends Equatable {
  final List<CategoryModel> subCategoryList;
  final Status status;
  final String message;

  const FetchSubCategoryState({
    this.message = "",
    this.status = Status.loading,
    this.subCategoryList = const [],
  });

  FetchSubCategoryState copyWith(
      {List<CategoryModel>? subCategoryList,
      Status? status,
      String? message,
      List<ProductModel>? subCategoryProductsList}) {
    return FetchSubCategoryState(
      message: message ?? this.message,
      status: status ?? this.status,
      subCategoryList: subCategoryList ?? this.subCategoryList,
    );
  }

  @override
  List<Object?> get props => [message, status, subCategoryList];
}
