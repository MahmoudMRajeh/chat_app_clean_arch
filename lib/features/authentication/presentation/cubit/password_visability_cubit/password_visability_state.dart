part of 'password_visability_cubit.dart';

abstract class PasswordVisabilityState extends Equatable {
  const PasswordVisabilityState();

  @override
  List<Object> get props => [];
}

class PasswordVisabilityInitial extends PasswordVisabilityState {
}
class PasswordVisabilityChange extends PasswordVisabilityState {
  final IconData icon;

  const PasswordVisabilityChange(this.icon);
}

