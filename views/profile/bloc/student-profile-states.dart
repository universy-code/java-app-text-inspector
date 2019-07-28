import 'package:equatable/equatable.dart';
import 'package:universy_mobile_client/com/universy/model/student/student.dart';

abstract class StudentProfileState extends Equatable {
  StudentProfileState([List props = const []]) : super(props);
}

class EditStudentProfileState extends StudentProfileState {
  final Student student;

  EditStudentProfileState(this.student) : super([student]);
}
class InfoStudentProfileInitialState extends StudentProfileState {
}

class InfoStudentProfileState extends StudentProfileState {
  final Student student;

  InfoStudentProfileState(this.student) : super([student]);
}
