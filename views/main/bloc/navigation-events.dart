
import 'package:equatable/equatable.dart';
import 'package:universy_mobile_client/com/universy/model/student/student.dart';

abstract class NavigationEvent extends Equatable {
  NavigationEvent([List props = const []]) : super(props);
}

class InitialEvent extends NavigationEvent {
}

class ProfileEvent extends NavigationEvent {
  final Student student;

  ProfileEvent(this.student) : super([student]);
}

class SubjectsEvent extends NavigationEvent {
}