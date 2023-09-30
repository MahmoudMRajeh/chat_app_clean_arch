import 'package:chat/features/chat/data/datasources/firestore_datasource.dart';
import 'package:chat/features/chat/domain/entities/messege_entity.dart';
import 'package:chat/features/chat/domain/repositories/messeges_repository.dart';

class MessegegesRepositoryImpl extends MessegegesRepository{
  final FireStoreDataSource fireStoreDataSource;

  MessegegesRepositoryImpl({required this.fireStoreDataSource});
  @override
  Stream<List<MessegeEntity>> getMesseges({required String secondUserId, required String firstUserId}) {
    return fireStoreDataSource.getMesseges(secondUserId: secondUserId, firstUserId: firstUserId);
  }

  @override
  Future<void> sendMessege({required MessegeEntity messege}) async{
    await fireStoreDataSource.setMessegeInMyCollection(messege: messege);
    await fireStoreDataSource.setMessegeInUserCollection(messege: messege);
  }
  
}