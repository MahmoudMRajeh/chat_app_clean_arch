import 'package:chat/core/errors/failures.dart';
import 'package:chat/features/authentication/data/datasources/local_data_source.dart';
import 'package:chat/features/authentication/data/models/user_model.dart';
import 'package:chat/features/authentication/domain/entities/user_entity.dart';
import 'package:chat/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import '../datasources/remote_firebase_datasource.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FireBaseDataSource fireBaseAuthDataSource;
  final LocalDataSource localDataSource;

  AuthRepositoryImpl(
      {required this.localDataSource, required this.fireBaseAuthDataSource});

  @override
  Future<Either<Failure, UserEntity>> userLogin(
      {required String email, required String password}) async {
    try {
      var response= await fireBaseAuthDataSource.userLogin(email: email, password: password);
      UserModel? user = await fireBaseAuthDataSource.getUser(id: response.user!.uid);
      if (user != null) {
        bool saved = await localDataSource.setCacheUser(uid: user.id);
        if (saved) {
          return Right(user);
        }
        return Left(CacheException("Fail to save data"));
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(
          "Error is ${e.code} and credential is ${e.credential} & plugin ${e.plugin} && msg is ${e.message}");
      if (e.code == 'user-not-found' || e.code == "invalid-email") {
        debugPrint('No user found for that email.');
        return Left(AuthException("User not found !."));
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
        return Left(AuthException("Wrong password try again !."));
      } else if (e.code == "INVALID_LOGIN_CREDENTIALS") {
        debugPrint('Invalid login credentials');
        return Left(AuthException("Please check email and password again !."));
      }
    } catch (e) {
      return Left(
          AuthException("Please check your email and password again !."));
    }
    return Left(AuthException("Please check your email and password again !."));
  }

  @override
  Future<Either<Failure, UserEntity>> userRegister(
      {required String email,
      required String name,
      required String password}) async {
    try {
      final response = await fireBaseAuthDataSource.userRegister(
          email: email, name: name, password: password);
      if (response != null) {
        bool saved = await localDataSource.setCacheUser(uid: response.id);
        if (saved) {
          return Right(response);
        }
        return Left(CacheException("Fail to save data"));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
        return Left(AuthException("The password provided is too weak."));
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
        return Left(AuthException("Email already exists."));
      }
    } catch (e) {
      return Left(AuthException("Something went wrong during authentication"));
    }
    return Left(AuthException("Something went wrong during authentication"));
  }
  @override
  Future<Either<Failure, String?>> getCacheUser() async {
    final response = await localDataSource.getStoredUser();
    if (response != null) {
      return Right(response);
    }
    return Left(CacheException("Fail to get saved data"));
  }
  @override
  Future<Either<Failure, bool>> userLogout() async {
    if (await fireBaseAuthDataSource.userLogOut() &&
        await localDataSource.removeLocalUser()) {
      return const Right(true);
    } else {
      return Left(AuthException("Failed to log out"));
    }
  }
}
