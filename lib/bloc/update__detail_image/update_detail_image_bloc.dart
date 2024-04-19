import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/update__detail_image/update_detail_image_event.dart';
import 'package:store/bloc/update__detail_image/update_detail_image_state.dart';
import 'package:store/features/shop/model/product_model/product_model.dart';

class UpdateDetailImageBloc
    extends Bloc<UpdateDetailImageEvents, UpdateDetailImageState> {
  UpdateDetailImageBloc(ProductModel productModel)
      : super(UpdateDetailImageState(
            selectedProductImage: productModel.thumbnail)) {
    on<UpdateDetailImage>(_updateDetailImage);
  }

  _updateDetailImage(
      UpdateDetailImage events, Emitter<UpdateDetailImageState> emit) async {
    emit(state.copyWith(selectedProductImage: events.image));
  }
}
