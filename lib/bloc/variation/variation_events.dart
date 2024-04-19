// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:store/features/shop/model/product_model/product_model.dart';

sealed class VariationEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class Variation extends VariationEvents {
  ProductModel productModel;
  String attributeName;
  String attributeValue;
  Variation(this.productModel, this.attributeName, this.attributeValue);
}
