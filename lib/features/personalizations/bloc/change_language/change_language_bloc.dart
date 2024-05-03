
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/features/personalizations/bloc/change_language/change_language_event.dart';
import 'package:store/features/personalizations/bloc/change_language/change_language_state.dart';
import 'package:store/utils/local_storage/storage_utility.dart';

class ChangeLanguageBloc
    extends Bloc<ChangeLangaugeEvent, ChangeLanguageState> {
  ChangeLanguageBloc() : super(const ChangeLanguageState()) {
    on<ChangeLanguage>(_changeLanguage);
    on<FetchLanguage>(_fetchLanguage);
  }
  _changeLanguage(
      ChangeLanguage event, Emitter<ChangeLanguageState> emit) async {
    if (event.index == 0) {
      await LocalStorage.instance().saveData("AppLanguage", 0);
      emit(state.copyWith(appLocale: const Locale("en")));
    } else {
      await LocalStorage.instance().saveData("AppLanguage", 1);
      emit(state.copyWith(appLocale: const Locale("ur")));
    }
  }

  _fetchLanguage(FetchLanguage event, Emitter<ChangeLanguageState> emit) async {
    final data = await LocalStorage.instance().readData("AppLanguage") ?? 0;
    if (data == 0) {
      emit(state.copyWith(appLocale: const Locale("en")));
    } else {
      emit(state.copyWith(appLocale: const Locale("ur")));
    }
  }
}
