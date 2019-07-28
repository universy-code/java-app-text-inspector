import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy_mobile_client/com/universy/model/student/student.dart';
import 'package:universy_mobile_client/com/universy/services/services-inherited.dart';
import 'package:universy_mobile_client/com/universy/services/universy/student/profile/exceptions/student-not-found.dart';
import 'package:universy_mobile_client/com/universy/views/main/bloc/navigation-bloc.dart';
import 'package:universy_mobile_client/com/universy/views/main/bloc/navigation-events.dart';
import 'package:universy_mobile_client/com/universy/views/main/widgets/drawer/items/student-subjects-item.dart';
import 'package:universy_mobile_client/com/universy/views/main/widgets/drawer/user-drawer-header.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          FutureBuilder(
            future: getCurrentStudentProfile(context),
            builder: drawerBuilder(),
          ),
          StudentSubjectItem()
        ],
      ),
    );
  }

  Future<Student> getCurrentStudentProfile(BuildContext context) async {
    try {
      return await Services.of(context).profileService().getStudentProfile();
    } on StudentNotFound catch (e) {
      return Future.error(e);
    } catch (e) {
      return Future.error(e);
    }
  }

  AsyncWidgetBuilder<Student> drawerBuilder() {
    return (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.hasData) {
        if (snapshot.data != null) {
          return UserDrawerHeader(student: snapshot.data);
        }
      }
      return UserDrawerHeader.loading();
    };
  }
}
