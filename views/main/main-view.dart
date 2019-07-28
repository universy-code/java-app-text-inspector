import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy_mobile_client/com/universy/apptext/application_text.dart';
import 'package:universy_mobile_client/com/universy/views/main/bloc/builders/app-bar-state-builder.dart';
import 'package:universy_mobile_client/com/universy/views/main/bloc/builders/body-state-builder.dart';
import 'package:universy_mobile_client/com/universy/views/main/bloc/builders/navigation-bar-state-builder.dart';
import 'package:universy_mobile_client/com/universy/views/main/bloc/navigation-bloc.dart';
import 'package:universy_mobile_client/com/universy/views/main/main-keys.dart';
import 'package:universy_mobile_client/com/universy/views/main/widgets/drawer/user-drawer.dart';

class MainView extends StatelessWidget {
  final _bloc = NavigationBloc();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: BlocProvider(
          bloc: _bloc,
          child: Scaffold(
              drawer: UserDrawer(),
              appBar: AppBar(
                  key: APP_BAR_KEY,
                  title: BlocBuilder(
                    bloc: _bloc,
                    builder: AppBarStateBuilder().builder(),
                  ),
                  backgroundColor: Colors.white),
              body: BlocBuilder(
                  bloc: _bloc, builder: BodyStateBuilder().builder()),
              bottomNavigationBar: BlocBuilder(
                  bloc: _bloc,
                  builder: NavigationBarStateBuilder().builder()))),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    //await Future.delayed(Duration.zero);
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(AppText.getInstance().get("willExit.title")),
            content: Text(AppText.getInstance().get("willExit.content")),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(AppText.getInstance().get("willExit.no")),
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(AppText.getInstance().get("willExit.yes")),
              ),
            ],
          ),
        ) ??
        false;
  }
}
