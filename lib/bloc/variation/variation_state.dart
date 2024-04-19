import 'package:equatable/equatable.dart';
import 'package:store/features/shop/model/product_variation/product_variation.dart';

// ignore: must_be_immutable
class VariationState extends Equatable {
  final Map<String, dynamic> selectedAttributes;
  final String variationStockStatus;
  ProductVariationModel? selectedVariation = ProductVariationModel.empty();

  VariationState({
    this.selectedVariation,
    this.selectedAttributes = const {},
    this.variationStockStatus = "",
  });

  VariationState copyWith(
      {Map<String, dynamic>? selectedAttributes,
      String? variationStockStatus,
      ProductVariationModel? selectedVariation}) {
    return VariationState(
      selectedAttributes: selectedAttributes ?? this.selectedAttributes,
      selectedVariation: selectedVariation ?? this.selectedVariation,
      variationStockStatus: variationStockStatus ?? this.variationStockStatus,
    );
  }

  @override
  List<Object?> get props =>
      [selectedAttributes, variationStockStatus, selectedVariation];
}
