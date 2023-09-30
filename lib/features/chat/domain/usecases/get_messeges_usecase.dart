import 'package:chat/features/chat/domain/entities/messege_entity.dart';

import '../repositories/messeges_repository.dart';

class GetMessegesUsecase {
  final MessegegesRepository messegegesRepository;

  GetMessegesUsecase({required this.messegegesRepository});
  Stream<List<MessegeEntity>> call(
          {required String secondUserId, required String firstUserId}) =>
      messegegesRepository.getMesseges(
          secondUserId: secondUserId, firstUserId: firstUserId);
}
