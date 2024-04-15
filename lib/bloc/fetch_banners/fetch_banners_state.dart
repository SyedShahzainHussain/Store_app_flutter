import 'package:equatable/equatable.dart';
import 'package:store/data/status/status.dart';
import 'package:store/features/shop/model/banner_model/banner_model.dart';

class FetchBannersState extends Equatable {
  final List<BannerModel> bannerList;
  final Status status;
  final String message;
  const FetchBannersState({
    this.bannerList = const [],
    this.status = Status.loading,
    this.message = "",
  });

  FetchBannersState copyWith({
    List<BannerModel>? bannerList,
    Status? status,
    String? message,
  }) {
    return FetchBannersState(
      bannerList: bannerList ?? this.bannerList,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [bannerList, status, message];
}
