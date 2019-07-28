import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable{
  AuthState([List props = const []]) : super(props);
}

class LoginState extends AuthState {
}

class LogonState extends AuthState {
}