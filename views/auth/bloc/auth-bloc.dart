import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:universy_mobile_client/com/universy/views/auth/bloc/auth-events.dart';

import 'auth-states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  @override
  AuthState get initialState => LoginState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event,) async* {
    if (event is LoginEvent) {
      yield LoginState();
    } else if(event is LogonEvent){
      yield LogonState();
    }
  }
}