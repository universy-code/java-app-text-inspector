import 'package:equatable/equatable.dart';
import 'package:universy_mobile_client/com/universy/apptext/application_text.dart';
import 'package:universy_mobile_client/com/universy/model/student/student.dart';

abstract class NavigationState extends Equatable{
  NavigationState([List props = const []]) : super(props);
}

class InitialState extends NavigationState {
}

class ProfileState extends NavigationState {
  final String title = AppText.getInstance().get("student.profile.title");
  final Student student;

  ProfileState(this.student) : super([student]);
}

class StudentSubjectsState extends NavigationState {
  final String title = AppText.getInstance().get("studentSubject.title");
}