import 'package:chat/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:chat/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_divider.dart';
import '../widgets/user_bubble.dart';

class AllUsersScreen extends StatelessWidget {
  const AllUsersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (ChatCubit.get(context).users.isNotEmpty || state is GetAllUsersSuccess) {
          return RefreshIndicator(
            onRefresh: () async {
              ChatCubit.get(context).getAllUsers(myUID: AuthenticationCubit.get(context).id!);
            },
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                  return UserBubble(
                    user: ChatCubit.get(context).users[index],
                  );
              },
              itemCount: ChatCubit.get(context).users.length,
              separatorBuilder: (context, index) {
                return const CustomDivider();
              },
            ),
          );
        }
        if (state is GetAllUsersLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is GetAllUsersFailure) {
          return Center(
            child: Text(state.errMsg),
          );
        } else {
          return Center();
        }
      },
    );
  }
}
