import 'package:chat/config/routes/app_routes.dart';
import 'package:chat/core/utils/media_query_values.dart';
import 'package:chat/core/widgets/custom_button.dart';
import 'package:chat/core/widgets/custom_text_feild.dart';
import 'package:chat/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:chat/features/authentication/presentation/cubit/password_visability_cubit/password_visability_cubit.dart';
import 'package:chat/features/authentication/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants/app_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    // ignore: use_build_context_synchronously
    Future.delayed(Duration.zero, () async {
      if (await AuthenticationCubit.get(context).getCacheId())
        Navigator.pushReplacementNamed(context, Routes.homeRoute);
    });

    super.initState();
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode? autovalidateMode = AutovalidateMode.disabled;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationUserLoginFailure) {
            isLoading = false;
            AppConstants.showToast(context,
                msg: state.errMsg, color: AppColors.failureColor);
          }
          if (state is AuthenticationUserLoginLoading) {
            isLoading = true;
          }
          if (state is AuthenticationUserLoginSuccess) {
            isLoading = false;
            AppConstants.showToast(context,
                msg: "Successfully login", color: AppColors.successColor);
            Navigator.pushReplacementNamed(context, Routes.homeRoute);
          }
        },
        builder: (context, state) {
          return AbsorbPointer(
            absorbing: isLoading,
            child: Form(
              key: _formKey,
              autovalidateMode: autovalidateMode,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: context.height * .2,
                    ),
                    Text(
                      "Login Now",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(
                      height: context.height * .04,
                    ),
                    CustomTextField(
                      controller: _emailController,
                      hintText: "Email",
                      prefixIcon: Icons.email_outlined,
                      onFieldSubmitted: (p0) {},
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: context.height * .04,
                    ),
                    BlocProvider(
                      create: (context) => PasswordVisabilityCubit(),
                      child: BlocBuilder<PasswordVisabilityCubit,
                          PasswordVisabilityState>(
                        builder: (context, state) {
                          return CustomTextField(
                            controller: _passwordController,
                            suffixIcon: PasswordVisabilityCubit.get(context)
                                .currentIcon,
                            obscureText:
                                PasswordVisabilityCubit.get(context).isObscured,
                            onSuffixIconPressed: () {
                              PasswordVisabilityCubit.get(context).change();
                            },
                            hintText: "Password",
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
                      buttonTxt: "Login",
                      isLoading: isLoading,
                      onButtonPressed: () {
                        if (_formKey.currentState!.validate()) {
                          AuthenticationCubit.get(context).userLogin(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
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
                        const Text("Don't have an account ? "),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.registerRoute);
                          },
                          child: const Text("Register now"),
                        ),
                      ],
                    ),
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
