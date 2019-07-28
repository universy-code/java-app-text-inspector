import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy_mobile_client/com/universy/model/student/student.dart';
import 'package:universy_mobile_client/com/universy/views/profile/bloc/builders/student-profile-state-builder.dart';
import 'package:universy_mobile_client/com/universy/views/profile/bloc/student-profile-bloc.dart';

class StudentProfileView extends StatelessWidget {
  final StudentProfileBloc _bloc = StudentProfileBloc();
  final Student _student;

  StudentProfileView({Key key, @required Student student})
      : this._student = student,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _bloc,
      child: Container(
        child: BlocBuilder(
            bloc: _bloc, builder: StudentProfileStateBuilder().builder(_student)),
      ),
    );
  }
}
