import 'package:chat/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.hintText,
      this.keyboardType = TextInputType.name,
      this.onChanged,
      this.onFieldSubmitted,
      this.prefixIcon,
      this.suffixIcon, this.initialValue, this.onSuffixIconPressed,  this.obscureText=false, this.controller});
  final String? hintText,initialValue;
  final TextInputType keyboardType;
  final void Function(String)? onChanged, onFieldSubmitted;
  final IconData? prefixIcon, suffixIcon;
  final void Function()? onSuffixIconPressed;
  final bool obscureText;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if(value!.isEmpty){
            return "Field must not be empty";
          }
          return null;
        },
        
        obscureText: obscureText,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        keyboardType: keyboardType,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        decoration: InputDecoration(
          
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          hintText: hintText,
          prefixIcon: Icon(
            prefixIcon,
          ),
          suffixIcon: IconButton(icon:Icon(suffixIcon),onPressed:onSuffixIconPressed ,),
          hintStyle: Theme.of(context).textTheme.bodyMedium,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primaryColor,
            ),
          ),
        ),
        style:const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        initialValue: initialValue,
      ),
    );
  }
}
