import 'package:chat/features/chat/data/datasources/firestore_datasource.dart';
import 'package:chat/features/chat/data/repositories/chats_repo_impl.dart';
import 'package:chat/features/chat/data/repositories/get_all_users_repo_impl.dart';
import 'package:chat/features/chat/data/repositories/messeges_repo_impl.dart';
import 'package:chat/features/chat/domain/repositories/chats_repo.dart';
import 'package:chat/features/chat/domain/repositories/get_all_users_repo.dart';
import 'package:chat/features/chat/domain/repositories/messeges_repository.dart';
import 'package:chat/features/chat/domain/usecases/get_all_users_usecase.dart';
import 'package:chat/features/chat/domain/usecases/get_messeges_usecase.dart';
import 'package:chat/features/chat/domain/usecases/send_messege_use_case.dart';
import 'package:chat/features/chat/domain/usecases/updata_chat_usecase.dart';
import 'package:chat/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:get_it/get_it.dart';

import 'domain/usecases/get_all_chats_usecase.dart';

final sl = GetIt.instance;
chat_init() {
  //cubits
  sl.registerFactory<ChatCubit>(() => ChatCubit(
      getAllUsersUseCase: sl(),
      getMessegesUsecase: sl(),
      sendMessegesUsecase: sl(), getAllChatsUsecase: sl(), updataChatUsecase: sl()));
  //use cases
  sl.registerLazySingleton(() => GetAllUsersUseCase(getAllUsersRepo: sl()));
  sl.registerLazySingleton(
      () => GetMessegesUsecase(messegegesRepository: sl()));
  sl.registerLazySingleton(
      () => SendMessegesUsecase(messegegesRepository: sl()));
  sl.registerLazySingleton(() => UpdataChatUsecase(chatsRepository: sl()));
    sl.registerLazySingleton(() => GetAllChatsUsecase(chatsRepository: sl()));

  //repositories
  sl.registerLazySingleton<ChatsRepository>(() => ChatsRepositoryImpl(fireStoreDataSource: sl()));
  sl.registerLazySingleton<GetAllUsersRepository>(
      () => GetAllUsersRepositoryImpl(fireStoreDataSource: sl()));
  sl.registerLazySingleton<MessegegesRepository>(
      () => MessegegesRepositoryImpl(fireStoreDataSource: sl()));
  //data sources
  sl.registerLazySingleton<FireStoreDataSource>(
    () => FireStoreDataSourceImpl(
      firestore: sl(),
    ),
  );
  //!external
  //sl.registerLazySingleton(() => FirebaseFirestore.instance);
}
