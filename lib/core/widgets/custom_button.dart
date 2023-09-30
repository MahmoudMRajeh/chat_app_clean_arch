import 'package:chat/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.buttonTxt,
      this.onButtonPressed,
      this.isLoading = false});
  final String buttonTxt;
  final void Function()? onButtonPressed;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonPressed,
      child: Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primaryColor,
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                color: Colors.white,
              )
              : Text(
                  buttonTxt,
                  style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
        ),
      ),
    );
  }
}
