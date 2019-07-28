import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:universy_mobile_client/com/universy/constants/subject-level-color.dart';
import 'package:universy_mobile_client/com/universy/model/career/career.dart';
import 'package:universy_mobile_client/com/universy/widgets/inkwell/cliped-ink-well.dart';
import 'package:universy_mobile_client/com/universy/widgets/paddings/edge/edge-padding.dart';

class SubjectCardWidget extends StatelessWidget {
  final Subject _subject;
  final SubjectCardTap _onCardTap;

  const SubjectCardWidget({Key key, Subject subject, SubjectCardTap onCardTap})
      : this._subject = subject,
        this._onCardTap = onCardTap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return EdgePaddingWidget(EdgeInsets.all(5.0), getSubjectCard(context));
  }

  Widget getSubjectCard(BuildContext context) {
    int level = _subject.level;
    Color color = getLevelColor(level);
    return Center(
      child: ClippedInkWell(
        onTap: onTap(context),
        splashColor: color,
        child: Container(
            width: 300,
            height: 75,
            child: Row(children: <Widget>[
              Expanded(child: getColorTag(color), flex: 1),
              Expanded(child: getLogoAndLevel(level), flex: 7),
              Expanded(child: getSubjectName(), flex: 12)
            ])),
      ),
    );
  }

  Widget getColorTag(Color color) {
    return SizedBox(child: Container(color: color));
  }

  Widget getLogoAndLevel(int level) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.book),
        SizedBox(height: 10),
        Container(child: Center(child: Text("Año: " + level.toString()))),
      ],
    );
  }

  Widget getSubjectName() {
    return Container(
        child: Text(_subject.name), alignment: Alignment.centerLeft);
  }

  VoidCallback onTap(BuildContext context) {
    return () => _onCardTap(context, _subject);
  }
}

typedef SubjectCardTap = void Function(BuildContext context, Subject subject);
