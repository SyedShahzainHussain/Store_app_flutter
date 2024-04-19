import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/update__detail_image/update_detail_image_bloc.dart';
import 'package:store/bloc/update__detail_image/update_detail_image_event.dart';
import 'package:store/bloc/variation/variation_events.dart';
import 'package:store/bloc/variation/variation_state.dart';
import 'package:store/features/shop/model/product_variation/product_variation.dart';
import 'package:store/utils/global_context/context_utils.dart';

class VariationBloc extends Bloc<VariationEvents, VariationState> {
  VariationBloc() : super(VariationState()) {
    on<Variation>(_variation);
  }

  // ! seleted variation
  void _variation(Variation event, Emitter<VariationState> emit) {
    // Create a modifiable copy of selectedAttributes
    final Map<String, dynamic> modifiableSelectedAttributes =
        Map<String, dynamic>.from(state.selectedAttributes);

    // Modify the copied map   Eg: {Color:Green},{Size:EU 32}
    modifiableSelectedAttributes[event.attributeName] = event.attributeValue;

    // Find the selected variation based on the modified attributes
    final isSelectedVariation = event.productModel.productVariationModel!
        .firstWhere(
            (variation) => _isSameAttributeValue(
                variation.attributeValues, modifiableSelectedAttributes),
            orElse: () => ProductVariationModel.empty());
    // Show the selected variant image in main images
    if (isSelectedVariation.image.isNotEmpty) {
      BlocProvider.of<UpdateDetailImageBloc>(ContextUtility.context)
          .add(UpdateDetailImage(isSelectedVariation.image));
    }

    // Update the state with the new selected attributes and variation
    emit(state.copyWith(
        selectedAttributes: modifiableSelectedAttributes,
        selectedVariation: isSelectedVariation,
        variationStockStatus:
            isSelectedVariation.stock > 0 ? "In Stock" : "Out of Stock"));
  }

  // ! check if the key is not same and the length is not same return false else return true

  bool _isSameAttributeValue(Map<String, dynamic> variationAttributes,
      Map<String, dynamic> seletectedAttribute) {
    // if both length are not equal return false
    if (variationAttributes.length != seletectedAttribute.length) return false;

    // if any of the attributes is different then return false
    for (final key in variationAttributes.keys) {
      if (variationAttributes[key] != seletectedAttribute[key]) return false;
    }

    return true;
  }

  // ! check the variation is avalaible and give the value of that keys
  Set<String?> getAttributesAvailabilityInVariation(
      List<ProductVariationModel> variations, String attributeName) {
    final avalible = variations
        .where((variation) =>
            variation.attributeValues[attributeName] != null &&
            variation.attributeValues[attributeName]!.isNotEmpty &&
            variation.stock > 0)
        .map((variations) => variations.attributeValues[attributeName])
        .toSet();
    return avalible;
  }
}
