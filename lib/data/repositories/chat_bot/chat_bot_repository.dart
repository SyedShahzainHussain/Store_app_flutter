import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:store/features/chatbot/model/ai_generated_model.dart';
import 'package:store/utils/constants/api_constants.dart';

class ChatBotRepository {
  Future<AIGeneratedModel> generateAIMsg(
      {required String url, required String prompt}) async {
    try {
      var mUri = Uri.parse(url);

      var response = await http.post(mUri,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${TApiString.CHAT_COMPLETION_API_KEY}",
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo-0125",
            "messages": [
              {"role": "user", "content": prompt},
            ],
               "temperature": 0.7
          }));
      if (response.statusCode == 200) {
        var mData = jsonDecode(response.body);
        if (mData["error"] != null) {
          throw (HttpException("Error: ${mData['error']['message']}"));
        } else {
          return AIGeneratedModel.fromJson(mData);
        }
      } else {
          var mData = jsonDecode(response.body);
        print("Error: ${mData['error']['message']}");
        throw (HttpException("Server error:${response.statusCode}"));
      }
    } catch (e) {
      throw HttpException(e.toString());
    }
  }
}
