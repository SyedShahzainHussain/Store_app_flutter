import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:store/features/chatbot/model/message_model.dart';

class ChatBotRepository {
  Future<String> generateAIMsg(
      {required String url, required List<MessageModel> messageModel}) async {
    try {
      var mUri = Uri.parse(url);

      var response = await http.post(mUri,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "contents": messageModel.map((e) => e.toJson()).toList(),
            "generationConfig": {
              "temperature": 1,
              "topK": 0,
              "topP": 0.95,
              "maxOutputTokens": 8192,
              "stopSequences": []
            },
            "safetySettings": [
              {
                "category": "HARM_CATEGORY_HARASSMENT",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              },
              {
                "category": "HARM_CATEGORY_HATE_SPEECH",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              },
              {
                "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              },
              {
                "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              }
            ]
          }));
      log(response.statusCode.toString());
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var mData = jsonDecode(response.body);
        return mData["candidates"].first["content"]["parts"].first["text"];
      } else {
        throw (HttpException("Server error:${response.statusCode}"));
      }
    } catch (e) {
      throw HttpException(e.toString());
    }
  }
}
