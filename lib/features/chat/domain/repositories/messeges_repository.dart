import 'package:chat/features/chat/domain/entities/messege_entity.dart';

abstract class MessegegesRepository{
  Future<void>sendMessege({required MessegeEntity messege});
  Stream<List<MessegeEntity>>getMesseges({required String secondUserId,required String firstUserId});
}