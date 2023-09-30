import 'package:chat/features/chat/domain/entities/chat_entity.dart';
import 'package:chat/features/chat/domain/repositories/chats_repo.dart';

class GetAllChatsUsecase{
  final ChatsRepository chatsRepository;

  GetAllChatsUsecase({required this.chatsRepository});
  Stream<List<ChatEntity>>call({required String uid})=>chatsRepository.getAllChats(uid: uid);
}