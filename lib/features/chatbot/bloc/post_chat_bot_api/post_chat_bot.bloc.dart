import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/data/repositories/chat_bot/chat_bot_repository.dart';
import 'package:store/features/chatbot/bloc/post_chat_bot_api/post_chat_bot.event.dart';
import 'package:store/features/chatbot/bloc/post_chat_bot_api/post_chat_bot_state.dart';
import 'package:store/features/chatbot/model/message_model.dart';
import 'package:store/utils/constants/api_constants.dart';

class PostChatBotBloc extends Bloc<PostChatBotEvent, PostChatBotState> {
  ChatBotRepository chatBotRepository = ChatBotRepository();
  final List<MessageModel> listMsg = [];
  bool loading = false;
  PostChatBotBloc() : super(PostChatBotSuccess(message: const [])) {
    on<SendChatBotAIMessage>(_sendChatBotAiMessage);
  }
  _sendChatBotAiMessage(
      SendChatBotAIMessage event, Emitter<PostChatBotState> emit) async {
    try {
      listMsg.add(
          MessageModel(role: "user", parts: [RoleModel(text: event.prompt)]));
      emit(PostChatBotSuccess().copyWith(message: List.from(listMsg)));

      loading = true;
      String generatedText = await chatBotRepository.generateAIMsg(
          url: TApiString.CHAT_COMPLETION_API, messageModel: listMsg);
      if (generatedText.isNotEmpty) {
        listMsg.add(MessageModel(
            role: "model", parts: [RoleModel(text: generatedText)]));
      }

      emit(PostChatBotSuccess().copyWith(message: List.from(listMsg)));
      loading = false;
    } catch (e) {
      listMsg.add(MessageModel(role: "model", parts: [RoleModel(text: "Error Occured")]));
      emit(PostChatBotSuccess().copyWith(message: List.from(listMsg)));
      loading = false;
    }
  }
}
