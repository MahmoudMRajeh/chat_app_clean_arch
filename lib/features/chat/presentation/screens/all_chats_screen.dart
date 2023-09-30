import 'package:chat/core/widgets/custom_divider.dart';
import 'package:chat/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:chat/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:chat/features/chat/presentation/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllChatsScreen extends StatelessWidget {
  const AllChatsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetAllChatsSuccess ||
            ChatCubit.get(context).allChat.isNotEmpty) {
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final chat = ChatCubit.get(context).allChat[index];
              String id;
              String name;
              if (chat.recipientUID == AuthenticationCubit.get(context).id) {
                id = chat.senderUID!;
                name = chat.senderName!;
              } else {
                id = chat.recipientUID!;
                name = chat.recipientName!;
              }
              return ChatBubble(
                name: name,
                image: chat.profileUrl!,
                id: id,
                msg: chat.lastMsg!,
                sender: chat.senderUID == AuthenticationCubit.get(context).id
                    ? "ME :"
                    : "",
              );
            },
            itemCount: ChatCubit.get(context).allChat.length,
            separatorBuilder: (context, index) {
              return const CustomDivider();
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
