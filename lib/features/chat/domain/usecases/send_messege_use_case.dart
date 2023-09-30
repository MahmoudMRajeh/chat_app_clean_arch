import 'package:chat/features/chat/domain/entities/messege_entity.dart';

import '../repositories/messeges_repository.dart';

class SendMessegesUsecase {
  final MessegegesRepository messegegesRepository;

  SendMessegesUsecase({required this.messegegesRepository});
  Future<void> call({
    required MessegeEntity messege,
  }) =>
      messegegesRepository.sendMessege(messege: messege);
}
