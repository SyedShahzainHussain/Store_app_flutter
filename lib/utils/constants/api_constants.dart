// ignore_for_file: constant_identifier_names

class TApiString {
  static TApiString? _apiString;
  TApiString._internal(); // Private constructor

  factory TApiString.instance() {
    _apiString ??= TApiString._internal();
    return _apiString!;
  }

  // static const CHAT_COMPLETION_API_KEY =
  //     "AIzaSyASq9-DRGDRMyoiQI_jBYoM2cJ6-Xd7ktQ";

  static const CHAT_COMPLETION_API =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyAqTV8FZWxe9qKGbLwvNS63cAZCVc7r-5o";
}
