import 'package:equatable/equatable.dart';

sealed class FetchBannersEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchBanners extends FetchBannersEvents {}
