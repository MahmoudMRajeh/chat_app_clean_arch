import 'package:chat/features/chat/presentation/screens/all_chats_screen.dart';
import 'package:chat/features/chat/presentation/screens/users_screen.dart';
import 'package:flutter/material.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../authentication/presentation/cubit/authentication_cubit.dart';
import '../cubit/chat_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    ChatCubit.get(context).getAllUsers(myUID: AuthenticationCubit.get(context).id! );
    ChatCubit.get(context).getAllChats(uid: AuthenticationCubit.get(context).id!);
    super.initState();
  }
  final List<Widget> _tabs = const [
    AllChatsScreen(),
    AllUsersScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  "Chats",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Tab(
                child: Text(
                  "Users",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                if (AuthenticationCubit.get(context).userEntity != null) {
                  Navigator.pushNamed(context, Routes.profileRoute);
                }
                if (AuthenticationCubit.get(context).userEntity == null) {
                  AuthenticationCubit.get(context).getMyProfile();
                  Navigator.pushNamed(context, Routes.profileRoute);
                }
              },
              icon: const Icon(
                Icons.person_2_rounded,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
        body: TabBarView(
          children: _tabs,
        ),
      ),
    );
  }
}
