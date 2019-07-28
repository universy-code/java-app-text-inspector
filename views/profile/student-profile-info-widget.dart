import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy_mobile_client/com/universy/apptext/application_text.dart';
import 'package:universy_mobile_client/com/universy/model/student/formatter/alias-formatter.dart';
import 'package:universy_mobile_client/com/universy/model/student/formatter/complete-name-formatter.dart';
import 'package:universy_mobile_client/com/universy/model/student/formatter/initials-formatter.dart';
import 'package:universy_mobile_client/com/universy/model/student/student.dart';
import 'package:universy_mobile_client/com/universy/views/profile/bloc/student-profile-bloc.dart';
import 'package:universy_mobile_client/com/universy/views/profile/bloc/student-profile-events.dart';
import 'package:universy_mobile_client/com/universy/widgets/paddings/edge/symetric/symetric-edge-padding.dart';

class StudentProfileInfoWidget extends StatefulWidget {
  final Student _student;

  const StudentProfileInfoWidget({Key key, @required Student student})
      : this._student = student,
        super(key: key);

  @override
  _StudentProfileInfoState createState() => _StudentProfileInfoState();
}

class _StudentProfileInfoState extends State<StudentProfileInfoWidget> {
  Student _student;

  @override
  void initState() {
    _student = widget._student;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: AlignmentDirectional.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildCircleAvatar(),
                _buildNameAndLastName(),
                _buildAlias(),
                _buildEditProfileButton(context)
              ],
            )));
  }

  Container _buildAlias() {
    return _getFormattedText(
        text: _getFormattedAlias(), fontWeight: FontWeight.normal);
  }

  Container _buildNameAndLastName() {
    return _getFormattedText(text: CompleteNameFormatter(_student).format());
  }

  SymmetricEdgePaddingWidget _buildCircleAvatar() {
    return SymmetricEdgePaddingWidget.vertical(
        paddingValue: 10,
        child: CircleAvatar(
          child: Text(
            InitialsFormatter(_student).format(),
            style: TextStyle(fontSize: 40.0),
          ),
          minRadius: 55,
        ));
  }

  SymmetricEdgePaddingWidget _buildEditProfileButton(BuildContext context) {
    return SymmetricEdgePaddingWidget.vertical(
        paddingValue: 15,
        child: GestureDetector(
          child: Text((AppText.getInstance().get("student.profile.editTitle")),
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 20,
                  color: Colors.blue)),
          onTap: _navigateToProfileEditWidget(context),
        ));
  }

  VoidCallback _navigateToProfileEditWidget(BuildContext context) {
    return () {
      final profileBloc = BlocProvider.of<StudentProfileBloc>(context);
      profileBloc.dispatch(EditStudentProfileEvent(_student));
    };
  }

  String _getFormattedAlias() => AliasFormatter(_student).format();

  Container _getFormattedText(
      {String text, FontWeight fontWeight = FontWeight.bold}) {
    return Container(
        child: Text(text,
            style: TextStyle(
                letterSpacing: 0.5, fontSize: 20, fontWeight: fontWeight),
            textAlign: TextAlign.end));
  }
}
