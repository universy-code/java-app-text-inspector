import 'package:equatable/equatable.dart';
import 'package:universy_mobile_client/com/universy/model/student/student.dart';

abstract class StudentProfileEvent extends Equatable {
  StudentProfileEvent([List props = const []]) : super(props);
}

class InfoStudentProfileEvent extends StudentProfileEvent {
  final Student student;

  InfoStudentProfileEvent(this.student) : super([student]);
}

class EditStudentProfileEvent extends StudentProfileEvent {
  final Student student;

  EditStudentProfileEvent(this.student) : super([student]);
}
