import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:universy_mobile_client/com/universy/views/profile/bloc/student-profile-events.dart';
import 'package:universy_mobile_client/com/universy/views/profile/bloc/student-profile-states.dart';

class StudentProfileBloc extends Bloc<StudentProfileEvent, StudentProfileState> {
  @override
  StudentProfileState get initialState => InfoStudentProfileInitialState();

  @override
  Stream<StudentProfileState> mapEventToState(
    StudentProfileEvent event,
  ) async* {
    if (event is InfoStudentProfileEvent) {
      yield InfoStudentProfileState(event.student);
    } else if (event is EditStudentProfileEvent) {
      yield EditStudentProfileState(event.student);
    }
  }
}
