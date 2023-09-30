import 'package:flutter/material.dart';
import '../screens/user_chat_screen.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.name,
    required this.image,
    required this.id,
    required this.msg,
    this.sender = "ME : ",
  });
  final String name;
  final String image;
  final String id;
  final String msg;
  final String? sender;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return UserChatScreen(
                id: id,
                image: image,
                name: name,
              );
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 12,bottom: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.cyan,
              child: CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(image),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    softWrap: false,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                  ),
                  Text(
                    "$sender $msg",
                    softWrap: false,
                    style:  TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
