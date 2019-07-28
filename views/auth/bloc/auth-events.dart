import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  AuthEvent([List props = const []]) : super(props);
}

class LoginEvent extends AuthEvent {
}

class LogonEvent extends AuthEvent {
}