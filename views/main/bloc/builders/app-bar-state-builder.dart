import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy_mobile_client/com/universy/apptext/application_text.dart';
import 'package:universy_mobile_client/com/universy/views/main/bloc/navigation-states.dart';

class AppBarStateBuilder {
  BlocWidgetBuilder<NavigationState> builder() {
    return (BuildContext context, NavigationState state) {

      String title = AppText.getInstance().get("home.title");

      if (state is ProfileState) {
        title = state.title;
      } else if (state is StudentSubjectsState) {
        title = state.title;
      }
      return Text(title);
    };
  }
}
