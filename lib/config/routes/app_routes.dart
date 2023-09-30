import 'package:chat/features/authentication/presentation/screens/login_screen.dart';
import 'package:chat/features/authentication/presentation/screens/register_screen.dart';
import 'package:chat/features/chat/presentation/screens/all_chats_screen.dart';
import 'package:chat/features/authentication/presentation/screens/profile_screen.dart';
import 'package:chat/features/chat/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../../core/utils/app_strings.dart';

class Routes {
  static const String loginRoute = "loginRoute";
  static const String registerRoute = "registerRoute";
  static const String homeRoute = "homeRoute";
  static const String allChatsRoute = "allChatsRoute";
  static const String chatRoute = "chatRoute";
  static const String profileRoute = "profileRoute";
}

class AppRoutes {
  static Route? onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        );
      case Routes.registerRoute:
        return MaterialPageRoute(
          builder: (context) {
            return const RegisterScreen();
          },
        );
      case Routes.homeRoute:
        return MaterialPageRoute(
          builder: (context) {
            return const HomeScreen();
          },
        );
      case Routes.profileRoute:
        return MaterialPageRoute(
          builder: (context) {
            return const ProfileScreen();
          },
        );
      case Routes.allChatsRoute:
        return MaterialPageRoute(
          builder: (context) {
            return  const AllChatsScreen();
          },
        );
      default:
        return AppRoutes.undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
