import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy_mobile_client/com/universy/apptext/application_text.dart';
import 'package:universy_mobile_client/com/universy/model/student/formatter/alias-formatter.dart';
import 'package:universy_mobile_client/com/universy/model/student/formatter/initials-formatter.dart';
import 'package:universy_mobile_client/com/universy/model/student/student.dart';
import 'package:universy_mobile_client/com/universy/views/main/bloc/navigation-bloc.dart';
import 'package:universy_mobile_client/com/universy/views/main/bloc/navigation-events.dart';

class UserDrawerHeader extends StatelessWidget {

  static const String LOADING_SYMBOL = "!";

  final Student _student;
  final bool _loading;

  const UserDrawerHeader(
      {Key key, @required Student student, bool loading = false})
      : this._student = student,
        this._loading = loading,
        super(key: key);

  factory UserDrawerHeader.loading() {
    Student student = _getStudentWithLoadingText();
    return UserDrawerHeader(student: student, loading: true);
  }

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
        decoration: BoxDecoration(color: Colors.orangeAccent),
        accountName: Text(
          _student.name,
          style: TextStyle(
              fontSize: 20.0,
              color: Colors.black54,
              fontWeight: FontWeight.bold),
        ),
        accountEmail: Text(
          AliasFormatter(_student).format(),
          style: TextStyle(fontSize: 18.0, color: Colors.black45),
        ),
        currentAccountPicture: GestureDetector(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                _getStudentInitials(),
                style: TextStyle(fontSize: 40.0, color: Colors.black87),
              ),
            ),
            onTap: _navigateToProfile(context)));
  }

  VoidCallback _navigateToProfile(BuildContext context) {
    return () {
      if (!_loading) {
        final navigationBloc = BlocProvider.of<NavigationBloc>(context);
        navigationBloc.dispatch(ProfileEvent(_student));
        Navigator.of(context).pop();
      }
    };
  }

  String _getStudentInitials() {
    if (_loading) {
      return LOADING_SYMBOL;
    } else {
      InitialsFormatter formatter = InitialsFormatter(_student);
      return formatter.format();
    }
  }

  static Student _getStudentWithLoadingText() {
    String loadingText = AppText.getInstance().get("student.loading");
    return Student(loadingText, loadingText, loadingText, loadingText);
  }
}
