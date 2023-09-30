import 'package:chat/config/routes/app_routes.dart';
import 'package:chat/config/themes/themes.dart';
import 'package:chat/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:chat/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat/features/authentication/auth_injection_container.dart'
    as auth_di;
import '../../features/chat/chats_injection_container.dart' as chat_di;

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationCubit(
            userLogoutUseCase: auth_di.sl(),
            getCacheUserUseCase: auth_di.sl(),
            userLoginUseCase: auth_di.sl(),
            userRegisterUseCase: auth_di.sl(),
            getUserProfileUseCase: auth_di.sl(),
            changePrfoilePhotoUseCase: auth_di.sl(),
            uploadPrfoilePhotoUseCase: auth_di.sl(),
            updataProfileDataUsecase: auth_di.sl(),
          ),
        ),
        BlocProvider(
          create: (context) => ChatCubit(
              getAllUsersUseCase: chat_di.sl(),
              getMessegesUsecase: chat_di.sl(),
              sendMessegesUsecase: chat_di.sl(),
              getAllChatsUsecase: chat_di.sl(),
              updataChatUsecase: chat_di.sl()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: lightTheme(),
        onGenerateRoute: AppRoutes.onGeneratedRoute,
        initialRoute: Routes.loginRoute,
      ),
    );
  }
}
