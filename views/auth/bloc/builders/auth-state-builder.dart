import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy_mobile_client/com/universy/views/auth/bloc/auth-states.dart';
import 'package:universy_mobile_client/com/universy/views/auth/bloc/widgets/login-widget.dart';
import 'package:universy_mobile_client/com/universy/views/auth/bloc/widgets/logon-widget.dart';
import 'package:universy_mobile_client/com/universy/views/main/bloc/navigation-states.dart';
import 'package:universy_mobile_client/com/universy/views/profile/student-profile-view.dart';
import 'package:universy_mobile_client/com/universy/views/student/subjects/student-subjects-view.dart';

class AuthStateBuilder {
  BlocWidgetBuilder<AuthState> builder() {
    return (BuildContext context, AuthState state) {
      if (state is LogonState) {
        return LogOnWidget();
      }
      return LogInWidget();
    };
  }
}
