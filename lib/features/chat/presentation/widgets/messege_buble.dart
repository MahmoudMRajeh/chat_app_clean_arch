import 'package:chat/features/chat/domain/entities/messege_entity.dart';
import 'package:flutter/material.dart';

class MessegeBuilder extends StatelessWidget {
  const MessegeBuilder({
    super.key,
    this.left = true, required this.content,required this.time,
  });
  final bool left;
  final String content;
  final dynamic time;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: left
              ? AlignmentDirectional.centerStart
              : AlignmentDirectional.centerEnd,
          child: Container(
            decoration: BoxDecoration(
              color:
                  left ? Colors.grey[400] : Colors.blueAccent.withOpacity(.6),
              borderRadius: left
                  ? const BorderRadiusDirectional.only(
                      bottomEnd: Radius.circular(10),
                      topStart: Radius.circular(10),
                      topEnd: Radius.circular(10),
                    )
                  : const BorderRadiusDirectional.only(
                      bottomStart: Radius.circular(10),
                      topStart: Radius.circular(10),
                      topEnd: Radius.circular(10),
                    ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(content),
                Text(
                  time,
                  style:const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
