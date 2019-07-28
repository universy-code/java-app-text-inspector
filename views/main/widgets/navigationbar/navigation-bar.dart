import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy_mobile_client/com/universy/app/theme/universy-theme.dart';
import 'package:universy_mobile_client/com/universy/apptext/application_text.dart';
import 'package:universy_mobile_client/com/universy/views/main/bloc/navigation-bloc.dart';
import 'package:universy_mobile_client/com/universy/views/main/bloc/navigation-events.dart';

class MainNavigationBar extends StatelessWidget {

  static const int MAIN_INDEX = 0;

  final int index;

  const MainNavigationBar({Key key, this.index}) : super(key: key);

  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) => onTabTapped(index, context),
      currentIndex: index,
      items: getNavItems(),
      backgroundColor: UniversyTheme.theme.primaryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black45,
      iconSize: 27,
    );
  }

  void onTabTapped(int index, BuildContext context) {
    final navigationBloc = BlocProvider.of<NavigationBloc>(context);

    if (index == MAIN_INDEX) {
      navigationBloc.dispatch(InitialEvent());
    }
  }
}

List<BottomNavigationBarItem> getNavItems() {
  return [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text(
        AppText.getInstance().get('home.navIcons.home'),
      ),
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.location_disabled),
        title: Text(
          AppText.getInstance().get('home.navIcons.notAvaiable'),
        )),
    BottomNavigationBarItem(
        icon: Icon(Icons.location_disabled),
        title: Text(
          AppText.getInstance().get('home.navIcons.notAvaiable'),
        ))
  ];
}
