import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ChangeLanguageState extends Equatable {
  final Locale appLocale;
  const ChangeLanguageState({this.appLocale = const Locale("en")});

  ChangeLanguageState copyWith({Locale? appLocale}) {
    return ChangeLanguageState(appLocale: appLocale ?? this.appLocale);
  }

  @override
  List<Object?> get props => [appLocale];
}
