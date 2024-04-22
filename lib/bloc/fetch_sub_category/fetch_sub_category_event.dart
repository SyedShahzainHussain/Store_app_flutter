sealed class FetchSubCategoryEvent {}

class FetchSubCategory extends FetchSubCategoryEvent {
  String categoryId;
  FetchSubCategory(this.categoryId);
}
