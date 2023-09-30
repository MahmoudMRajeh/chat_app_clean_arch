import 'package:chat/core/utils/media_query_values.dart';
import 'package:flutter/material.dart';
class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container (
      child: Divider(
        indent: context.width*.08,
        endIndent: context.width*.08,
        color: Colors.black,
        thickness: .8,
      ),
    );
  }
}