import 'package:chat/features/chat/data/datasources/firestore_datasource.dart';
import 'package:chat/features/chat/domain/entities/chat_entity.dart';
import 'package:chat/features/chat/domain/repositories/chats_repo.dart';

class ChatsRepositoryImpl extends ChatsRepository {
  final FireStoreDataSource fireStoreDataSource;

  ChatsRepositoryImpl({required this.fireStoreDataSource});
  @override
  Stream<List<ChatEntity>> getAllChats({required String uid}) {
    return fireStoreDataSource.getAllChats(uid: uid);
  }

  @override
  Future<void> updateChat(
      {required String myUID,
      required String recipientUID,
      required Map<String, dynamic> document}) async {
    await fireStoreDataSource.updateChat(
        myUID: myUID, recipientUID: recipientUID, document: document);
    await fireStoreDataSource.updateChat(
        myUID: recipientUID, recipientUID: myUID, document: document);
  }
}
