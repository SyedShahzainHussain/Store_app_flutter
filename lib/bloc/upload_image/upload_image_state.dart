sealed class UploadImageState {}

class UploadImageInitial extends UploadImageState {}

class UploadImageLoading extends UploadImageState {}

class UploadImageSuccess extends UploadImageState {}

class UploadImageError extends UploadImageState {
  String message;
  UploadImageError(this.message);
}
