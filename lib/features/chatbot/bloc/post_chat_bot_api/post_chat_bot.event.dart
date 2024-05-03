sealed class PostChatBotEvent {}

class SendChatBotAIMessage extends PostChatBotEvent {
  String prompt;
  SendChatBotAIMessage(this.prompt);
}
