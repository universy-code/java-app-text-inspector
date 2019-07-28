import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy_mobile_client/com/universy/apptext/application_text.dart';
import 'package:universy_mobile_client/com/universy/views/main/bloc/navigation-bloc.dart';
import 'package:universy_mobile_client/com/universy/views/main/bloc/navigation-events.dart';

class StudentSubjectItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(AppText.getInstance().get("studentSubject.title")),
      onTap: dispatchSubjectsEvent(context),
    );
  }

  VoidCallback dispatchSubjectsEvent(BuildContext context) {
    return () {
      final navigationBloc = BlocProvider.of<NavigationBloc>(context);
      navigationBloc.dispatch(SubjectsEvent());
      Navigator.of(context).pop();
    };
  }
}
