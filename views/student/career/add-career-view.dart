import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:universy_mobile_client/com/universy/assets/assets.dart';
import 'package:universy_mobile_client/com/universy/model/institution/institution.dart';
import 'package:universy_mobile_client/com/universy/services/services-inherited.dart';
import 'package:universy_mobile_client/com/universy/views/student/career/add-career-widget.dart';
import 'package:universy_mobile_client/com/universy/widgets/cards/rectangle/circular/circular-rounded-rectangle-card.dart';
import 'package:universy_mobile_client/com/universy/widgets/containers/background/background-container.dart';
import 'package:universy_mobile_client/com/universy/widgets/logos/logo-widget.dart';
import 'package:universy_mobile_client/com/universy/widgets/paddings/edge/symetric/symetric-edge-padding.dart';
import 'package:universy_mobile_client/com/universy/widgets/scrollable/listview/scrollable-list-view.dart';

class AddCareerView extends StatelessWidget {
  Widget build(BuildContext context) {
    return BackgroundContainer(
      child: ScrollableListView(
        children: <Widget>[createUniversyLogoWidget(), createStudentDataWidget(context)],
      ),
      asset: Assets.UNIVERSY_MAIN_BACKGROUND,
    );
  }

  Widget createStudentDataWidget(BuildContext context) {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 8.0,
      child: CircularRoundedRectangleCard(
        radius: 18,
        color: Colors.white,
        child: FutureBuilder(
          future: getInstitutions(context),
          builder: addCareerWidgetBuilder(),
        )
      ),
    );
  }

  Widget createUniversyLogoWidget() {
    return LogoWidget(
        logoAsset: Assets.UNIVERSY_MAIN_LOGO, width: 180, height: 145);
  }

  Future<Institutions> getInstitutions(BuildContext context) {
    try {
      return Services.of(context).institutionService().getInstitutions();
    } catch (e) {
      // What to do in errors in Future?
      log("Error fetching");
      return null;
    }
  }

  AsyncWidgetBuilder<Institutions> addCareerWidgetBuilder() {
    return (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.hasData) {
        if (snapshot.data != null) {
          return AddCareerWidget(institutions: snapshot.data);
        }
      }
      return SizedBox(
        child:
        Center(child: CircularProgressIndicator()),
        height: 50.0,
        width: 50.0);
    };
  }
}
