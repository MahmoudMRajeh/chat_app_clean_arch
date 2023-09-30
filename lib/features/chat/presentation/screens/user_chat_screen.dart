import 'dart:async';

import 'package:chat/core/widgets/custom_text_feild.dart';
import 'package:chat/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:chat/features/authentication/presentation/screens/profile_screen.dart';
import 'package:chat/features/chat/domain/entities/messege_entity.dart';
import 'package:chat/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:chat/features/chat/presentation/widgets/messege_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class UserChatScreen extends StatefulWidget {
  const UserChatScreen(
      {super.key, required this.id, required this.name, required this.image});
  final String id;
  final String name;
  final String image;
  @override
  State<UserChatScreen> createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _messageController.addListener(() {
      setState(() {});
    });

    ChatCubit.get(context).getMesseges(
        firstUserId: AuthenticationCubit.get(context).id!,
        secondUserId: widget.id);
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      automaticallyImplyLeading: false,
      actions: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {

                          return ProfileScreen(
                            id: widget.id,
                            me: false,
                          );
                        },
                      ));
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.blue,
                          child: CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(widget.image),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Flexible(
                          child: Text(
                            widget.name,
                            softWrap: false,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetAllMessegesSuccess || ChatCubit.get(context).chatMesseges.isNotEmpty) {
            return Column(
              children: [
                _messegesListView(messeges: ChatCubit.get(context).chatMesseges, recipientId: widget.id),
                CustomTextField(
                  controller: _messageController,
                  prefixIcon: Icons.message_rounded,
                  suffixIcon: Icons.send,
                  onSuffixIconPressed: () {
                    if (_messageController.text.isEmpty) {
                    } else {
                      ChatCubit.get(context).sendMessege(
                        messege: MessegeEntity(
                          content: _messageController.text,
                          senderId: AuthenticationCubit.get(context).id,
                          recipientId: widget.id,
                          time: Timestamp.now(),
                          receiverName: widget.name,
                          senderName: AuthenticationCubit.get(context).userEntity!.name,
                        ),
                        profileUrl: widget.image,
                        myUID: AuthenticationCubit.get(context).id!,
                        recipientUID: widget.id,
                        
                      );
                      setState(() {
                        _messageController.clear();
                      });
                    }
                  },
                  onFieldSubmitted: (p0) {
                    if (_messageController.text.isEmpty) {
                    } else {
                      ChatCubit.get(context).sendMessege(
                        messege: MessegeEntity(
                          content: _messageController.text,
                          senderId: AuthenticationCubit.get(context).id,
                          recipientId: widget.id,
                          time: Timestamp.now(),
                          receiverName: widget.name,
                          senderName: AuthenticationCubit.get(context).userEntity!.name,
                        ),
                        profileUrl: widget.image,
                        myUID: AuthenticationCubit.get(context).id!,
                        recipientUID: widget.id,
                      );
                      setState(() {
                        _messageController.clear();
                      });
                    }
                  },
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _messegesListView({
    required String recipientId,
    required List<MessegeEntity> messeges,
  }) {
    Timer(const Duration(milliseconds: 100), () {
      if(_scrollController.hasClients){
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInQuad,
      );
      }
    });
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemBuilder: (context, index) {
          final messege = messeges[index];
          return MessegeBuilder(
            left: messege.recipientId != recipientId,
            content: messege.content!,
            time: DateFormat('hh:mm a').format(
              messege.time!.toDate(),
            ),
          );
        },
        itemCount: messeges.length,
      ),
    );
  }
}
