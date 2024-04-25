import 'package:equatable/equatable.dart';
import 'package:store/features/chatbot/model/message_model.dart';

sealed class PostChatBotState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostChatBotInitial extends PostChatBotState {}

class PostChatBotLoading extends PostChatBotState {}

class PostChatBotSuccess extends PostChatBotState {
  final List<MessageModel> message;

  PostChatBotSuccess({this.message = const []});

  PostChatBotSuccess copyWith({List<MessageModel>? message}) {
    return PostChatBotSuccess(message: message ?? this.message);
  }
}

class PostChatBotError extends PostChatBotState {
  final List<MessageModel> message;

  PostChatBotError({this.message = const []});

  PostChatBotError copyWith({List<MessageModel>? message}) {
    return PostChatBotError(message: message ?? this.message);
  }
}
