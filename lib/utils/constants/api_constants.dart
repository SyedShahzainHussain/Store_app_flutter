// ignore_for_file: constant_identifier_names

class TApiString {
 static TApiString? _apiString;
  TApiString._internal(); // Private constructor

  factory TApiString.instance() {
    _apiString ??= TApiString._internal();
    return _apiString!;
  }

  static const CHAT_COMPLETION_API_KEY =
      "sk-proj-lvYKBj6m8WdUceG2IP6VT3BlbkFJqwrQM0CkBR9saHOtoEbM";

  static const BASE_URL = "https://api.openai.com/v1/";
  static const CHAT_COMPLETION_API = "${BASE_URL}chat/completions";
}
