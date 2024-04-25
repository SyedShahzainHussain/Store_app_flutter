import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/features/chatbot/bloc/post_chat_bot_api/post_chat_bot.bloc.dart';
import 'package:store/features/chatbot/bloc/post_chat_bot_api/post_chat_bot.event.dart';
import 'package:store/features/chatbot/bloc/post_chat_bot_api/post_chat_bot_state.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  var promptController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBar(
          title: Text('Meta Ai'),
          showBackArrow: true,
        ),
        body: Column(
          children: [
            BlocBuilder<PostChatBotBloc, PostChatBotState>(
              builder: (context, state) {
                if (state is PostChatBotLoading) {
                  return const Text("Loading...");
                } else if (state is PostChatBotSuccess) {
                  return Expanded(
                    child: ListView.builder(
                        reverse: true,
                        itemCount: state.message.length,
                        itemBuilder: (context, index) {
                          var msgModel = state.message[index];
                          return msgModel.senderId == 1
                              ? Container(
                                  padding: const EdgeInsets.all(11),
                                  color: Colors.blue.shade200,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: TColors.primary,
                                        radius: 25,
                                        child: Image.asset(
                                            TImageString.chatReply,
                                            width: 17,
                                            height: 17),
                                      ),
                                      const SizedBox(
                                        width: 11,
                                      ),
                                      Expanded(
                                          child: DefaultTextStyle(
                                        style: const TextStyle(
                                            color: Colors.white),
                                        child: AnimatedTextKit(
                                          totalRepeatCount: 1,
                                          repeatForever: false,
                                          animatedTexts: [
                                            TypewriterAnimatedText(
                                              msgModel.msg,
                                            ),
                                          ],
                                        ),
                                      )),
                                    ],
                                  ))
                              : Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(11.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          DateFormat.Hm().format(DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  msgModel.sentAt)),
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .copyWith(color: Colors.grey),
                                        ),
                                        Text(
                                          msgModel.msg,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                        }),
                  );
                } else {
                  return const Expanded(child: SizedBox());
                }
              },
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + TSized.xsm,
                left: TSized.md,
                right: TSized.md,
                top: TSized.xsm,
              ),
              child: TextFormField(
                enableSuggestions: true,
                controller: promptController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: TColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  suffixIcon: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    child: InkWell(
                        onTap: () {
                          BlocProvider.of<PostChatBotBloc>(context)
                              .add(SendChatBotAIMessage(promptController.text));
                          promptController.clear();
                        },
                        child: const Icon(Icons.send)),
                  ),
                  hintText: 'Write a message...',
                ),
              ),
            )
          ],
        ));
  }
}
