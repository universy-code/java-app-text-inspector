import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:universy_mobile_client/com/universy/model/career/career.dart';
import 'package:universy_mobile_client/com/universy/services/services-inherited.dart';
import 'package:universy_mobile_client/com/universy/services/universy/career/classifier/default-subject-classifier.dart';
import 'package:universy_mobile_client/com/universy/views/student/subjects/student-subjects-widget.dart';
import 'package:universy_mobile_client/com/universy/widgets/progressindicator/circular/center-sized-circular.dart';

class StudentSubjectView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getStudentSubject(context),
      builder: studentSubjectBuilder(),
    );
  }

  Future<Career> getStudentSubject(BuildContext context) {
    return Services.of(context).careerService().getCareer();
  }

  AsyncWidgetBuilder<Career> studentSubjectBuilder() {
    return (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.hasData) {
        if (snapshot.data != null) {
          return Container(
            child: StudentSubjectWidget(
                career: snapshot.data,
                classifier: DefaultSubjectClassifier()),
          );
        }
      }
      return CenterSizedCircularProgressIndicator(width: 50.0, height: 50.0);
    };
  }
}
