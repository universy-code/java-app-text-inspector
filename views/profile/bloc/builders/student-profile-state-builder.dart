import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy_mobile_client/com/universy/model/student/student.dart';
import 'package:universy_mobile_client/com/universy/views/profile/bloc/student-profile-states.dart';
import 'package:universy_mobile_client/com/universy/views/profile/student-profile-edit-widget.dart';
import 'package:universy_mobile_client/com/universy/views/profile/student-profile-info-widget.dart';

class StudentProfileStateBuilder {
  BlocWidgetBuilder<StudentProfileState> builder(Student initialStudent) {
    return (BuildContext context, StudentProfileState state) {
      if (state is InfoStudentProfileInitialState) {
        return StudentProfileInfoWidget(student: initialStudent);
      } else if (state is InfoStudentProfileState) {
        return StudentProfileInfoWidget(student: state.student);
      } else if (state is EditStudentProfileState) {
        return StudentProfileEditWidget(student: state.student);
      } else
        return Container();
    };
  }
}
