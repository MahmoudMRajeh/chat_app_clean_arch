import 'package:chat/core/errors/failures.dart';
import 'package:chat/features/authentication/domain/entities/user_entity.dart';
import 'package:chat/features/authentication/domain/usecases/get_cache_user_usecase.dart';
import 'package:chat/features/authentication/domain/usecases/get_user_profile_usecase.dart';
import 'package:chat/features/authentication/domain/usecases/update_profile_data_usecase.dart';
import 'package:chat/features/authentication/domain/usecases/user_login_usecase.dart';
import 'package:chat/features/authentication/domain/usecases/user_logout_usecase.dart';
import 'package:chat/features/authentication/domain/usecases/user_register_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/change_profile_photo_usecase.dart';
import '../../domain/usecases/upload_profile_photo_usecase.dart';
part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({
    required this.userLogoutUseCase,
    required this.updataProfileDataUsecase,
    required this.changePrfoilePhotoUseCase,
    required this.uploadPrfoilePhotoUseCase,
    required this.getUserProfileUseCase,
    required this.getCacheUserUseCase,
    required this.userLoginUseCase,
    required this.userRegisterUseCase,
  }) : super(AuthenticationInitial());
  final GetUserProfileUseCase getUserProfileUseCase;
  final UserLogoutUseCase userLogoutUseCase;
  final UserLoginUseCase userLoginUseCase;
  final UserRegisterUseCase userRegisterUseCase;
  final GetCacheUserUseCase getCacheUserUseCase;
  final ChangePrfoilePhotoUseCase changePrfoilePhotoUseCase;
  final UploadPrfoilePhotoUseCase uploadPrfoilePhotoUseCase;
  final UpdataProfileDataUsecase updataProfileDataUsecase;
  static AuthenticationCubit get(context) => BlocProvider.of(context);
  UserEntity? userEntity;
  String? id;
  userLogin({required String email, required String password}) async {
    emit(AuthenticationUserLoginLoading());
    Either<Failure, UserEntity> response =
        await userLoginUseCase.call(email: email, password: password);
    response.fold((l) {
      emit(AuthenticationUserLoginFailure(l.errMsg));
    }, (user) {
      userEntity = user;
      id = userEntity!.id;
      print("user entity id =${userEntity!.id}");
      emit(AuthenticationUserLoginSuccess());
    });
  }

  userRegister({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(AuthenticationUserRegisterLoading());
    Either<Failure, UserEntity> response = await userRegisterUseCase.call(
        email: email, password: password, name: name);
    response.fold((l) {
      emit(AuthenticationUserRegisterFailure(l.errMsg));
    }, (user) {
      userEntity = user;
      id = userEntity!.id;
      emit(AuthenticationUserRegisterSuccess());
    });
  }

  userLogout() async {
    emit(AuthenticationUserLogoutLoading());
    final response = await userLogoutUseCase.call();
    response.fold((l) {
      emit(AuthenticationUserLogoutFailure(l.errMsg));
    }, (r) {
      userEntity = null;
      id = null;
      print("success log out");
      emit(AuthenticationUserLogoutSuccess());
    });
  }

  Future<bool> getCacheId() async {
    Either<Failure, String?> response = await getCacheUserUseCase.call();
    bool successGet = false;
    response.fold((l) {}, (uid) {
      if (uid != null) {
        id = uid;
        successGet = true;
        print("id is = $id");
      }
    });
    return successGet;
  }

  Future<UserEntity?> getMyProfile() async {
    emit(GetUserProfileLoading());
    final response = await getUserProfileUseCase.call(id: id ?? "");
    response.fold((l) {
      emit(AuthenticationUserLoginFailure(l.errMsg));
    }, (r) {
      userEntity = r;
      id = userEntity!.id;
      emit(GetUserProfileSuccess());
      return r;
    });
    return null;
  }

  List<UserEntity> users = [];
  UserEntity?user;
  getUserProfile({required String uid}) async {
    user=null;
    emit(GetUserProfileLoading());
    for (var x in users) {
      if (x.id == uid) {
        user=x;
        emit(GetUserProfileSuccess());
      }
    }
    final response = await getUserProfileUseCase.call(id: uid);
    response.fold((l) {
      emit(AuthenticationUserLoginFailure(l.errMsg));
    }, (r) {
      user=r;
      emit(GetUserProfileSuccess());
    });
  }

  Future<void> changeProfilePhoto() async {
    final response = await changePrfoilePhotoUseCase.call();
    response.fold((l) {
      emit(PickProfileImageFailure(l.errMsg));
    }, (image) async {
      emit(UpdateProfileImageLoading());
      final updataResponse =
          await uploadPrfoilePhotoUseCase.call(image: image, id: id!);
      updataResponse.fold((l) {
        emit(UpdateProfileImageFailure(l.errMsg));
      }, (r) {
        userEntity = null;
        getMyProfile();
      });
    });
  }

  Future<void> updataProfileData({String? newName, String? newBio}) async {
    if (newName == userEntity!.name && newBio == userEntity!.bio) {
      emit(const UpdateProfileDataFailure("Data must be updated"));
    }
    emit(UpdateProfileDataLoading());
    final String name;
    if (newName == "" || newName == null) {
      name = userEntity!.name;
    } else {
      name = newName;
    }
    final response =
        await updataProfileDataUsecase.call(id: id!, name: name, bio: newBio);
    response.fold((l) {
      emit(UpdateProfileDataFailure(l.errMsg));
    }, (r) {
      emit(UpdateProfileDataSuccess());
      userEntity = null;
      getMyProfile();
    });
  }
}
