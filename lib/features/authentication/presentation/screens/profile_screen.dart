import 'package:chat/config/routes/app_routes.dart';
import 'package:chat/core/utils/app_colors.dart';
import 'package:chat/core/utils/constants/app_constants.dart';
import 'package:chat/core/widgets/profile_builder.dart';
import 'package:chat/features/authentication/domain/entities/user_entity.dart';
import 'package:chat/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:chat/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.user, this.me = false, this.id});
  final UserEntity? user;
  final bool me;
  final String? id;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _bio = TextEditingController();
  @override
  Widget _body() => BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationUserLogoutSuccess) {
            Navigator.pushReplacementNamed(context, Routes.loginRoute);
          }
          if (state is AuthenticationUserLogoutFailure) {
            AppConstants.showToast(context,
                msg: state.errMsg, color: AppColors.failureColor);
          }
        },
        builder: (context, state) {
          if (!widget.me) {
            if (widget.user == null && widget.id!=null) {
              return ProfileBuilder(
                  user:
                  ChatCubit.get(context).getUserProfile(uid: widget.id!)!);
            }
            if (widget.user != null) {
              return ProfileBuilder(
                me: false,
                user: widget.user!,
              );
            }
          }
          if (state is AuthenticationUserLogoutLoading) {
            return Center(
              child: Column(
                children: const [
                  CircularProgressIndicator(),
                  Text("Loging out"),
                ],
              ),
            );
          }
          if (AuthenticationCubit.get(context).userEntity == null) {
            if (state is GetUserProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is GetUserProfileFailure) {
              return Center(
                child: Row(
                  children: [
                    Text(
                      state.errMsg,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                      onPressed: () {
                        AuthenticationCubit.get(context).getMyProfile();
                      },
                      child: const Text(
                        "Try again",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              );
            }
          } else if (AuthenticationCubit.get(context).userEntity != null) {
            return ProfileBuilder(
              me: widget.user != null ? false : true,
              user: widget.user ?? AuthenticationCubit.get(context).userEntity!,
              bioController: widget.user != null ? null : _name,
              nameController: widget.user != null ? null : _bio,
            );
          }
          return Column(
            children: [],
          );
        },
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.user == null
            ? const Text("My Profile")
            : const Text("Profile"),
        actions: [
          IconButton(
              onPressed: () {
                AppConstants.showErrorDialog(context,
                    msg: "Are you want to log out?", onOkPressed: () {
                  AuthenticationCubit.get(context).userLogout();
                }, onCancelPressed: () {
                  Navigator.pop(context);
                });
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: _body(),
    );
  }
}
