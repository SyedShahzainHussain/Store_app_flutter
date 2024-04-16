import 'package:equatable/equatable.dart';

sealed class FetchProductsEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class GetProductsEvent extends FetchProductsEvents {}
