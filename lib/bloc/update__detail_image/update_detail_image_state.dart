import 'package:equatable/equatable.dart';

class UpdateDetailImageState extends Equatable {
  final String? selectedProductImage;
  const UpdateDetailImageState({this.selectedProductImage = ''});

  UpdateDetailImageState copyWith({String? selectedProductImage}) {
    return UpdateDetailImageState(
        selectedProductImage:
            selectedProductImage ?? this.selectedProductImage);
  }

  @override
  List<Object?> get props => [selectedProductImage];
}
