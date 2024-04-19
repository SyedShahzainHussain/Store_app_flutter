import 'package:equatable/equatable.dart';
import 'package:store/data/status/status.dart';
import 'package:store/features/shop/model/brand_model/brand_model.dart';

class BrandState extends Equatable {
  final List<BrandModel> allBrand;
  final List<BrandModel> featuredBrand;
  final Status status;
  final String message;

  const BrandState({
    this.allBrand = const [],
    this.featuredBrand = const [],
    this.status = Status.loading,
    this.message = "",
  });

  BrandState copyWith({
    List<BrandModel>? allBrand,
    List<BrandModel>? featuredBrand,
    Status? status,
    String? message,
  }) {
    return BrandState(
      allBrand: allBrand ?? this.allBrand,
      featuredBrand: featuredBrand ?? this.featuredBrand,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [allBrand, featuredBrand, status, message];
}
