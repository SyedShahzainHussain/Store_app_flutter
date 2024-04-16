import 'package:equatable/equatable.dart';

sealed class UpdateDetailImageEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateDetailImage extends UpdateDetailImageEvents {
  final String image;
   UpdateDetailImage(this.image);
}

class UpdateAllImages extends UpdateDetailImageEvents {
    final List<String> images;

    UpdateAllImages(this.images);
}
