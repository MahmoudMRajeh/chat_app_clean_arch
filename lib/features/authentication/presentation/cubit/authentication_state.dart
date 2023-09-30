part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationUserLoginLoading extends AuthenticationState {}

class AuthenticationUserLoginSuccess extends AuthenticationState {}

class AuthenticationUserLoginFailure extends AuthenticationState {
  final String errMsg;

  const AuthenticationUserLoginFailure(this.errMsg);
}

class AuthenticationUserRegisterLoading extends AuthenticationState {}

class AuthenticationUserRegisterSuccess extends AuthenticationState {}

class AuthenticationUserRegisterFailure extends AuthenticationState {
  final String errMsg;
  const AuthenticationUserRegisterFailure(this.errMsg);
}

class AuthenticationUserLogoutLoading extends AuthenticationState {}

class AuthenticationUserLogoutSuccess extends AuthenticationState {}

class AuthenticationUserLogoutFailure extends AuthenticationState {
  final String errMsg;
  const AuthenticationUserLogoutFailure(this.errMsg);
}

class GetUserProfileLoading extends AuthenticationState {}

class GetUserProfileSuccess extends AuthenticationState {}

class GetUserProfileFailure extends AuthenticationState {
  final String errMsg;

  const GetUserProfileFailure(this.errMsg);
}

class PickProfileImageSuccess extends AuthenticationState {}

class PickProfileImageFailure extends AuthenticationState {
  final String errMsg;

  const PickProfileImageFailure(this.errMsg);
}
class UpdateProfileImageLoading extends AuthenticationState {}

class UpdateProfileImageSuccess extends AuthenticationState {}

class UpdateProfileImageFailure extends AuthenticationState {
  final String errMsg;
  const UpdateProfileImageFailure(this.errMsg);
}
class UpdateProfileDataLoading extends AuthenticationState {}
class UpdateProfileDataSuccess extends AuthenticationState {}

class UpdateProfileDataFailure extends AuthenticationState {
  final String errMsg;
  const UpdateProfileDataFailure(this.errMsg);
}