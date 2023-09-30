import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../app_colors.dart';

class AppConstants {
  static const String defaultProfileImage =
      "https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg";

  static void showErrorDialog(BuildContext context,
      {required String msg,
      required void Function()? onOkPressed,
      required void Function()? onCancelPressed}) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            msg,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          actions: [
            TextButton(
              onPressed: onOkPressed,
              style: TextButton.styleFrom(
                textStyle:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              child: const Text("OK"),
            ),
            TextButton(
              onPressed:onCancelPressed,
              style: TextButton.styleFrom(
                textStyle:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  static void showToast(BuildContext context,
      {required String msg, required Color color, ToastGravity? gravity}) {
    Fluttertoast.showToast(
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: color,
      gravity: gravity ?? ToastGravity.BOTTOM,
      msg: msg,
    );
  }
}
