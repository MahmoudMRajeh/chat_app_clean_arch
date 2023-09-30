import 'package:chat/features/authentication/auth_injection_container.dart';
import 'package:chat/features/chat/chats_injection_container.dart';

init()async{
  await auth_init();
  chat_init();
}