import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'password_visability_state.dart';

class PasswordVisabilityCubit extends Cubit<PasswordVisabilityState> {
  PasswordVisabilityCubit() : super(PasswordVisabilityInitial());
  static PasswordVisabilityCubit get(context)=>BlocProvider.of(context);
  bool isObscured=true;
  IconData obscured=Icons.remove_red_eye_outlined;
  IconData notObscured=Icons.remove_red_eye;
  IconData currentIcon=Icons.remove_red_eye_outlined;
  void change(){
    emit(PasswordVisabilityInitial());
    isObscured=! isObscured;
    currentIcon=isObscured?obscured:notObscured;
    emit(PasswordVisabilityChange(currentIcon));
  }
}
