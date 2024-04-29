sealed class ChangeLangaugeEvent {}

class ChangeLanguage extends ChangeLangaugeEvent {
  int index;
  ChangeLanguage(this.index);
}

class FetchLanguage extends ChangeLangaugeEvent {
  FetchLanguage();
}
