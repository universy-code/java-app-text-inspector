import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy_mobile_client/com/universy/apptext/application_text.dart';
import 'package:universy_mobile_client/com/universy/assets/assets.dart';
import 'package:universy_mobile_client/com/universy/views/auth/bloc/auth-bloc.dart';
import 'package:universy_mobile_client/com/universy/views/login/login-widget.dart';
import 'package:universy_mobile_client/com/universy/widgets/cards/rectangle/circular/circular-rounded-rectangle-card.dart';
import 'package:universy_mobile_client/com/universy/widgets/containers/background/background-container.dart';
import 'package:universy_mobile_client/com/universy/widgets/logos/logo-widget.dart';
import 'package:universy_mobile_client/com/universy/widgets/paddings/edge/symetric/symetric-edge-padding.dart';
import 'package:universy_mobile_client/com/universy/widgets/scrollable/listview/scrollable-list-view.dart';

import 'bloc/builders/auth-state-builder.dart';

class AuthView extends StatelessWidget {
  final _bloc = AuthBloc();

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: BackgroundContainer(
        child: ScrollableListView(
          children: <Widget>[createUniversyLogoWidget(), createLogInWidget()],
        ),
        asset: Assets.UNIVERSY_MAIN_BACKGROUND,
      ),
    );
  }

  Widget createLogInWidget() {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 8.0,
      child: CircularRoundedRectangleCard(
        radius: 18,
        color: Colors.white,
        child: BlocProvider(
          bloc: _bloc,
          child: BlocBuilder(
            bloc: _bloc,
            builder: AuthStateBuilder().builder(),
          ),
        ),
      ),
    );
  }

  Widget createUniversyLogoWidget() {
    return LogoWidget(
        logoAsset: Assets.UNIVERSY_MAIN_LOGO, width: 180, height: 145);
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
    ) ?? false;
  }

}
