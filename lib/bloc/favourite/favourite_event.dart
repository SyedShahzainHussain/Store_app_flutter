sealed class FavouriteEvent {}
class GetAllFavourite extends FavouriteEvent{}
class ToggleFavourite extends FavouriteEvent {
  String productId;
  ToggleFavourite(this.productId);
}
class GetFavourite extends FavouriteEvent{}
