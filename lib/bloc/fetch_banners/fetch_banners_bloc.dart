import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:store/bloc/fetch_banners/fetch_banners_events.dart';
import 'package:store/bloc/fetch_banners/fetch_banners_state.dart';
import 'package:store/data/repositories/categories/categories_repository.dart';
import 'package:store/data/status/status.dart';
import 'package:store/features/shop/model/banner_model/banner_model.dart';

class FetchBannersBloc extends Bloc<FetchBannersEvents, FetchBannersState> {
  List<BannerModel> bannersList = [];
  CategoriesRepository categoriesRepository = CategoriesRepository();
  FetchBannersBloc() : super(const FetchBannersState()) {
    on<FetchBanners>(_fetchBanners);
  }
  Future<void> _fetchBanners(
      FetchBanners events, Emitter<FetchBannersState> emit) async {
    try {
      // ! get all banners
      bannersList = await categoriesRepository.getAllBanners();
      emit(state.copyWith(
        bannerList: List.from(bannersList),
        message: "Banners Fetch Successfully",
        status: Status.success,
      ));
    } catch (e) {
      emit(state.copyWith(
          bannerList: [], message: e.toString(), status: Status.failure));
    }
  }
}
