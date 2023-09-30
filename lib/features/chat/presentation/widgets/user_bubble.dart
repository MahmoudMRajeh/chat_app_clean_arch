import 'package:chat/features/authentication/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

import '../screens/user_chat_screen.dart';

class UserBubble extends StatelessWidget {
  const UserBubble({super.key, required this.user});
  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return UserChatScreen(
                id: user.id,
                image: user.profileImage!,
                name: user.name,
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
                backgroundImage: NetworkImage(user.profileImage!),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Column(
                children: [
                  Text(
                    user.name,
                    softWrap: false,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
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
