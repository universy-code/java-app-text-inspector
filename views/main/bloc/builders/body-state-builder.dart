import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy_mobile_client/com/universy/views/main/bloc/navigation-states.dart';
import 'package:universy_mobile_client/com/universy/views/profile/student-profile-view.dart';
import 'package:universy_mobile_client/com/universy/views/student/subjects/student-subjects-view.dart';

class BodyStateBuilder {
  BlocWidgetBuilder<NavigationState> builder() {
    return (BuildContext context, NavigationState state) {
      if (state is InitialState) {
        return Container();
      } else if (state is ProfileState) {
        return StudentProfileView(student: state.student);
      } else if (state is StudentSubjectsState) {
        return StudentSubjectView();
      } else {
        return Container();
      }
    };
  }
}
