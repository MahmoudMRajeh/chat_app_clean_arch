import 'package:chat/core/utils/app_colors.dart';
import 'package:chat/core/utils/constants/app_constants.dart';
import 'package:chat/core/utils/media_query_values.dart';
import 'package:chat/core/widgets/custom_button.dart';
import 'package:chat/core/widgets/custom_text_feild.dart';
import 'package:chat/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:chat/features/authentication/presentation/cubit/password_visability_cubit/password_visability_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  AutovalidateMode? autovalidateMode = AutovalidateMode.disabled;
  final _formKey = GlobalKey<FormState>();
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationUserRegisterFailure) {
            AppConstants.showToast(context,
                msg: state.errMsg, color: AppColors.failureColor);
          }
          if (state is AuthenticationUserRegisterLoading) {
            isLoading = true;
          }
          if (state is AuthenticationUserRegisterSuccess) {
            isLoading = false;
            AppConstants.showToast(context,
                msg: "Successfully register", color: AppColors.successColor);
            Navigator.pushReplacementNamed(context, Routes.homeRoute);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: AbsorbPointer(
              absorbing: isLoading,
              child: Form(
                key: _formKey,
                autovalidateMode: autovalidateMode,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: context.height * .2,
                    ),
                    Text(
                      "Register Now",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(
                      height: context.height * .05,
                    ),
                    CustomTextField(
                      hintText: "Name",
                      controller: _nameController,
                      prefixIcon: Icons.person_2_outlined,
                      onFieldSubmitted: (p0) {},
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(
                      height: context.height * .02,
                    ),
                    CustomTextField(
                      hintText: "Email",
                      controller: _emailController,
                      prefixIcon: Icons.email_outlined,
                      onFieldSubmitted: (p0) {},
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: context.height * .02,
                    ),
                    BlocProvider(
                      create: (context) => PasswordVisabilityCubit(),
                      child: BlocBuilder<PasswordVisabilityCubit,
                          PasswordVisabilityState>(
                        builder: (context, state) {
                          return CustomTextField(
                            suffixIcon:
                                PasswordVisabilityCubit.get(context).currentIcon,
                            obscureText:
                                PasswordVisabilityCubit.get(context).isObscured,
                            onSuffixIconPressed: () {
                              PasswordVisabilityCubit.get(context).change();
                            },
                            hintText: "Password",
                            controller: _passwordController,
                            prefixIcon: Icons.lock_outline,
                            keyboardType: TextInputType.visiblePassword,
                            onFieldSubmitted: (p0) {},
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: context.height * .02,
                    ),
                    CustomButton(
                      buttonTxt: "Register",
                      isLoading: isLoading,
                      onButtonPressed: () {
                        if (_formKey.currentState!.validate()) {
                          AuthenticationCubit.get(context).userRegister(
                              email: _emailController.text,
                              password: _passwordController.text,
                              name: _nameController.text);
                        } else {
                          setState(() {
                            autovalidateMode = AutovalidateMode.always;
                          });
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account ? "),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Login now"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
