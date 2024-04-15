import 'package:equatable/equatable.dart';
import 'package:store/data/status/status.dart';
import 'package:store/features/shop/model/categories_model/categories_model.dart';

class FetchCategoriesState extends Equatable {
  final List<CategoryModel> categoriesList;
  final List<CategoryModel> featuresCategories;

  final Status status;
  final String message;

  const FetchCategoriesState({
    this.categoriesList = const [],
    this.status = Status.loading,
    this.featuresCategories = const [],
    this.message = "",
  });

  FetchCategoriesState copyWith({
    List<CategoryModel>? categoriesList,
    Status? status,
    List<CategoryModel>? featuresCategories,
    String? message,
  }) {
    return FetchCategoriesState(
      categoriesList: categoriesList ?? this.categoriesList,
      status: status ?? this.status,
      featuresCategories: featuresCategories ?? this.featuresCategories,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [categoriesList, status, featuresCategories];
}
