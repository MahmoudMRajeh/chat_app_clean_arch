import 'package:chat/features/authentication/data/datasources/local_data_source.dart';
import 'package:chat/features/authentication/data/datasources/remote_firebase_datasource.dart';
import 'package:chat/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:chat/features/authentication/data/repositories/change_profile_photo_repo_impl.dart';
import 'package:chat/features/authentication/data/repositories/get_user_profile_repo_impl.dart';
import 'package:chat/features/authentication/data/repositories/updata_profile_data_repo_impl.dart';
import 'package:chat/features/authentication/domain/repositories/auth_repository.dart';
import 'package:chat/features/authentication/domain/repositories/get_user_profile_repo.dart';
import 'package:chat/features/authentication/domain/repositories/updata_profile_data_repo.dart';
import 'package:chat/features/authentication/domain/usecases/get_cache_user_usecase.dart';
import 'package:chat/features/authentication/domain/usecases/get_user_profile_usecase.dart';
import 'package:chat/features/authentication/domain/usecases/update_profile_data_usecase.dart';
import 'package:chat/features/authentication/domain/usecases/user_login_usecase.dart';
import 'package:chat/features/authentication/domain/usecases/user_logout_usecase.dart';
import 'package:chat/features/authentication/domain/usecases/user_register_usecase.dart';
import 'package:chat/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/repositories/change_profile_photo_repo.dart';
import 'domain/usecases/change_profile_photo_usecase.dart';
import 'domain/usecases/upload_profile_photo_usecase.dart';

final sl = GetIt.instance;

Future<void> auth_init() async {
  //cubits
  sl.registerFactory(() => AuthenticationCubit(
      userLoginUseCase: sl(),
      userRegisterUseCase: sl(),
      getCacheUserUseCase: sl(),
      userLogoutUseCase: sl(),
      getUserProfileUseCase: sl(),
      changePrfoilePhotoUseCase: sl(),
      uploadPrfoilePhotoUseCase: sl(),
      updataProfileDataUsecase: sl()));
  //usecases
  sl.registerLazySingleton(() => UserLoginUseCase(sl()));
  sl.registerLazySingleton(() => UserRegisterUseCase(sl()));
  sl.registerLazySingleton(() => GetCacheUserUseCase(sl()));
  sl.registerLazySingleton(() => UserLogoutUseCase(sl()));
  sl.registerLazySingleton(
      () => GetUserProfileUseCase(getUserProfileRepository: sl()));
  sl.registerLazySingleton(
      () => ChangePrfoilePhotoUseCase(changePrfoilePhotoRepository: sl()));
  sl.registerLazySingleton(
      () => UploadPrfoilePhotoUseCase(changePrfoilePhotoRepository: sl()));
  sl.registerLazySingleton(
      () => UpdataProfileDataUsecase(updataProfileDataRepo: sl()));
  // repositories
  sl.registerLazySingleton<AuthRepository>(() =>
      AuthRepositoryImpl(fireBaseAuthDataSource: sl(), localDataSource: sl()));
  sl.registerLazySingleton<GetUserProfileRepository>(
      () => GetUserProfileRepositoryImpl(fireBaseDataSource: sl()));
  sl.registerLazySingleton<ChangePrfoilePhotoRepository>(() =>
      ChangePrfoilePhotoRepositoryImpl(
          fireBaseDataSource: sl(), localDataSource: sl()));
  sl.registerLazySingleton<UpdataProfileDataRepo>(
      () => UpdataProfileDataRepoImpl(
            fireBaseDataSource: sl(),
          ));
  // datasources
  sl.registerLazySingleton<FireBaseDataSource>(() => FireBaseAuthDataSourceImpl(
      auth: sl(), firestore: sl(), firebaseStorage: sl()));
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(prefs: sl()));
  //! external
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);
}
