import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:store/utils/global_context/context_utils.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/routes/route_name.dart';

part 'on_board_controller_event.dart';
part 'on_board_controller_state.dart';

class OnBoardControllerBloc
    extends Bloc<OnBoardControllerEvent, OnBoardControllerState> {
  PageController pageController = PageController();

  OnBoardControllerBloc() : super(const OnBoardControllerState()) {
    on<OnBoardControllerPageChange>(_onBoardControllerPageChange);
    on<OnBoardControllerSkipPage>(_onBoardControllerSkipPage);
    on<OnBoardControllerNextPage>(_onBoardControllerNextPage);
  }
  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }

  

  // ! page changed
  _onBoardControllerPageChange(
      OnBoardControllerPageChange event, Emitter<OnBoardControllerState> emit) {
    int currentPage = state.currentPage;
    currentPage = event.index;

    emit(state.copyWith(currentPage: currentPage));
  }
  // ! skip page

  _onBoardControllerSkipPage(OnBoardControllerSkipPage event,
      Emitter<OnBoardControllerState> emit) async {
    int currentPage = state.currentPage;
    currentPage = 2;
    pageController.animateToPage(
      2,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );
    emit(state.copyWith(currentPage: currentPage));
  }
  // ! next page

  _onBoardControllerNextPage(OnBoardControllerNextPage event,
      Emitter<OnBoardControllerState> emit) async {
    int currentPage = state.currentPage;
    if (currentPage == 2) {
      final storage = GetStorage();
      await storage.write("IsFirstTime", false);
      if (ContextUtility.context.mounted) {
        THelperFunction.navigatedToScreen(
            ContextUtility.context, RouteName.login);
      }
    } else {
      pageController.animateToPage(
        currentPage + 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    }
    emit(state.copyWith(currentPage: currentPage));
  }
}
