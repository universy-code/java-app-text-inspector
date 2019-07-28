import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:universy_mobile_client/com/universy/apptext/application_text.dart';
import 'package:universy_mobile_client/com/universy/constants/milestone-types.dart';
import 'package:universy_mobile_client/com/universy/model/career/career.dart';
import 'package:universy_mobile_client/com/universy/services/universy/career/classifier/subject-classifier.dart';
import 'package:universy_mobile_client/com/universy/views/student/subjects/subject-list-widget.dart';

class StudentSubjectWidget extends StatelessWidget {
  final Career _career;
  final SubjectClassifier _classifier;

  const StudentSubjectWidget(
      {Key key, Career career, SubjectClassifier classifier})
      : this._career = career,
        this._classifier = classifier,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    SubjectClassifierResult result = _classifier.classify(_career.subjects);
    int initialIndex = getInitialIndex(result);
    return Scaffold(
        backgroundColor: Color(0x9ab2d9),
        body: SizedBox.expand(
            // TODO: use an aspect ratio here for tablet support.. if needed
            child: PageView(
                physics: BouncingScrollPhysics(),
                controller: PageController(
                    viewportFraction: 0.8, initialPage: initialIndex),
                children: <Widget>[
              _buildToTakeList(result),
              _buildTakingList(result),
              _buildRegularList(result),
              _buildApprovedList(result)
            ])));
  }

  SubjectList _buildApprovedList(SubjectClassifierResult result) {
    return SubjectList(
        title: AppText.getInstance().get("studentSubject.approved"),
        subjects: result.approved);
  }

  SubjectList _buildRegularList(SubjectClassifierResult result) {
    return SubjectList(
        title: AppText.getInstance().get("studentSubject.regular"),
        subjects: result.regular);
  }

  SubjectList _buildTakingList(SubjectClassifierResult result) {
    return SubjectList(
        title: AppText.getInstance().get("studentSubject.taking"),
        subjects: result.taking);
  }

  SubjectList _buildToTakeList(SubjectClassifierResult result) {
    return SubjectList(
        title: AppText.getInstance().get("studentSubject.toTake"),
        subjects: result.toTake);
  }

  int getInitialIndex(SubjectClassifierResult result) {
    if (result.taking.isEmpty) {
      if (result.toTake.isEmpty) {
        if (result.regular.isEmpty) {
          return APPROVED_INDEX;
        } else {
          return REGULAR_INDEX;
        }
      } else {
        return TO_TAKE_INDEX;
      }
    } else {
      return TAKING_INDEX;
    }
  }
}
