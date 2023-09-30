import 'package:chat/features/chat/domain/entities/messege_entity.dart';
import 'package:chat/features/chat/domain/repositories/chats_repo.dart';

class UpdataChatUsecase {
  final ChatsRepository chatsRepository;

  UpdataChatUsecase({required this.chatsRepository});
  Future<void> call({required String myUID, required String recipientUID,required Map<String,dynamic>document}) =>
      chatsRepository.updateChat(myUID: myUID, recipientUID: recipientUID,document:document);
}
