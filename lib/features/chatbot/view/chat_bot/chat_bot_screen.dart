import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/features/chatbot/bloc/post_chat_bot_api/post_chat_bot.bloc.dart';
import 'package:store/features/chatbot/bloc/post_chat_bot_api/post_chat_bot.event.dart';
import 'package:store/features/chatbot/bloc/post_chat_bot_api/post_chat_bot_state.dart';
import 'package:store/features/chatbot/model/message_model.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final promptController = TextEditingController();
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    // Listen to Bloc state changes to scroll down when new messages arrive
    BlocProvider.of<PostChatBotBloc>(context).stream.listen((state) {
      if (state is PostChatBotSuccess) {
        _scrollToBottom();
      }
    });
  }

  void _scrollToBottom() {
    // Ensure the controller is attached before scrolling
    if (scrollController.hasClients) {
      WidgetsBinding.instance.addPostFrameCallback((_) =>
          scrollController.jumpTo(scrollController.position.maxScrollExtent));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBar(
          title: Text('Meta Ai'),
          showBackArrow: true,
        ),
        body: BlocBuilder<PostChatBotBloc, PostChatBotState>(
            builder: (context, state) {
          switch (state.runtimeType) {
            case const (PostChatBotSuccess):
              final List<MessageModel> messages =
                  (state as PostChatBotSuccess).message;
              return Column(
                children: [
                  Expanded(
                    child: messages.isEmpty
                        ? const Center(
                            child: Text("Search With Meta AI"),
                          )
                        : ListView.builder(
                            controller: scrollController,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final msgModel = messages[index];
                              return buildMessage(msgModel);
                            },
                          ),
                  ),
                  if (BlocProvider.of<PostChatBotBloc>(context).loading)
                    Row(
                      children: [
                        SizedBox(
                            height: 100,
                            width: 100,
                            child: Lottie.asset(TImageString.chatModelLoader)),
                        const SizedBox(width: 20),
                        const Text("Loading...")
                      ],
                    ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom:
                          MediaQuery.of(context).viewInsets.bottom + TSized.xsm,
                      left: TSized.md,
                      right: TSized.md,
                      top: TSized.xsm,
                    ),
                    child: TextFormField(
                      enableSuggestions: true,
                      controller: promptController,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 10),
                          child: InkWell(
                            onTap: () {
                              if (promptController.text.isNotEmpty) {
                                BlocProvider.of<PostChatBotBloc>(context).add(
                                    SendChatBotAIMessage(
                                        promptController.text));
                                promptController.clear();
                                _scrollToBottom();
                              }
                            },
                            child: const Icon(Icons.send),
                          ),
                        ),
                        hintText: 'Write a message...',
                      ),
                    ),
                  ),
                ],
              );
            default:
              return const SizedBox();
          }
        }));
  }

  Widget buildMessage(MessageModel msgModel) {
    return msgModel.role == "model"
        ? Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            padding: const EdgeInsets.all(11),
            color: Colors.blue.shade200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: TColors.primary,
                  radius: 25,
                  child: Image.asset(TImageString.chatReply,
                      width: 17, height: 17),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: DefaultTextStyle(
                    style: const TextStyle(color: Colors.white),
                    child: AnimatedTextKit(
                      totalRepeatCount: 1,
                      repeatForever: false,
                      isRepeatingAnimation: false,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          msgModel.parts!.first.text,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    msgModel.parts!.first.text,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
  }
}
