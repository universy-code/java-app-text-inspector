import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:universy_mobile_client/com/universy/model/career/career.dart';
import 'package:universy_mobile_client/com/universy/views/student/subjects/subject-card-widget.dart';

class SubjectList extends StatelessWidget {

  final String _title;
  final List<Subject> _subjects;

  const SubjectList({Key key, @required String title, @required List<Subject> subjects}) :
        this._title = title,
        this._subjects = subjects,
        super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            title: Text(_title)),
        body: ListView.builder(
            itemCount: _subjects.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: getSubjectBuilder(_subjects)
        )
    );
  }

  IndexedWidgetBuilder getSubjectBuilder(List<Subject> subjects){
    return (BuildContext context, int index){
      Subject subject = subjects[index];
      return SubjectCardWidget(
        subject: subject,
        //TODO: Here should be the state change.
        onCardTap: (context, subject) => print("tapped"),
      );
    };
  }

}