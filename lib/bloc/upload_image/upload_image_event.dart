import 'package:image_picker/image_picker.dart';

sealed class UploadImageEvent {}

class UploadImage extends UploadImageEvent {
  final XFile? image;
  UploadImage(this.image);
}
