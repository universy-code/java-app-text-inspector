import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy_mobile_client/com/universy/views/main/bloc/navigation-states.dart';
import 'package:universy_mobile_client/com/universy/views/main/widgets/navigationbar/navigation-bar.dart';

class NavigationBarStateBuilder {
  BlocWidgetBuilder<NavigationState> builder() {
    return (BuildContext context, NavigationState state) {
      int index = 0;
      // TODO: Add other events. Should we use bloc here?
      return MainNavigationBar(index: index);
    };
  }
}
