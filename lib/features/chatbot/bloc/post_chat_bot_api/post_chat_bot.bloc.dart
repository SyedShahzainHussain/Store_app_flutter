import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/data/repositories/chat_bot/chat_bot_repository.dart';
import 'package:store/features/chatbot/bloc/post_chat_bot_api/post_chat_bot.event.dart';
import 'package:store/features/chatbot/bloc/post_chat_bot_api/post_chat_bot_state.dart';
import 'package:store/features/chatbot/model/ai_generated_model.dart';
import 'package:store/features/chatbot/model/message_model.dart';
import 'package:store/utils/constants/api_constants.dart';

class PostChatBotBloc extends Bloc<PostChatBotEvent, PostChatBotState> {
  final List<MessageModel> listMsg = [];
  ChatBotRepository chatBotRepository = ChatBotRepository();
  PostChatBotBloc() : super(PostChatBotInitial()) {
    on<SendChatBotAIMessage>(_sendChatBotAiMessage);
  }

  _sendChatBotAiMessage(
      SendChatBotAIMessage event, Emitter<PostChatBotState> emit) async {
    listMsg.insert(
        0,
        MessageModel(
            msg: event.prompt,
            senderId: 0,
            sentAt: DateTime.now().millisecondsSinceEpoch));

    try {
      emit(PostChatBotLoading());
      AIGeneratedModel mData = await chatBotRepository.generateAIMsg(
          url: TApiString.CHAT_COMPLETION_API, prompt: event.prompt);
      log(mData.toString());
      listMsg.insert(
          0,
          MessageModel(
              msg: mData.choices![0].message!.content!,
              senderId: 1,
              sentAt: DateTime.now().millisecondsSinceEpoch));

      emit(PostChatBotSuccess().copyWith(message: List.from(listMsg)));
    } catch (e) {
      listMsg.insert(
          0,
          MessageModel(
              msg: e.toString(),
              senderId: 1,
              sentAt: DateTime.now().millisecondsSinceEpoch));
      emit(PostChatBotSuccess().copyWith(message: List.from(listMsg)));
      log(e.toString());
    }
  }
}
