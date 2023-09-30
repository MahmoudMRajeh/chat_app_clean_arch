import 'package:chat/features/chat/domain/entities/chat_entity.dart';
import 'package:chat/features/chat/domain/entities/messege_entity.dart';

abstract class ChatsRepository {
  Stream<List<ChatEntity>> getAllChats({required String uid});
  Future<void> updateChat(
      {required String myUID,
      required String recipientUID,
      required Map<String,dynamic>document});
}
