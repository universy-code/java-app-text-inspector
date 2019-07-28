import 'package:flutter/material.dart';
import 'package:universy_mobile_client/com/universy/assets/assets.dart';
import 'package:universy_mobile_client/com/universy/views/logon/logon-widget.dart';
import 'package:universy_mobile_client/com/universy/widgets/cards/rectangle/circular/circular-rounded-rectangle-card.dart';
import 'package:universy_mobile_client/com/universy/widgets/containers/background/background-container.dart';
import 'package:universy_mobile_client/com/universy/widgets/logos/logo-widget.dart';
import 'package:universy_mobile_client/com/universy/widgets/paddings/edge/symetric/symetric-edge-padding.dart';
import 'package:universy_mobile_client/com/universy/widgets/scrollable/listview/scrollable-list-view.dart';

class LogOnView extends StatelessWidget {
  Widget build(BuildContext context) {
    return BackgroundContainer(
      child: ScrollableListView(
        children: <Widget>[createUniversyLogoWidget(), createLogOnWidget()],
      ),
      asset: Assets.UNIVERSY_MAIN_BACKGROUND,
    );
  }

  Widget createLogOnWidget() {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 8.0,
      child: CircularRoundedRectangleCard(
          radius: 18, color: Colors.white, child: LogOnWidget()),
    );
  }

  Widget createUniversyLogoWidget() {
    return LogoWidget(
        logoAsset: Assets.UNIVERSY_MAIN_LOGO, width: 180, height: 145);
  }
}
