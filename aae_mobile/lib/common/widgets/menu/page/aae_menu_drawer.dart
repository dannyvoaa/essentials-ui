import 'package:aae/common/widgets/menu/drawer/aae_drawer_component.dart';
import 'package:aae/common/widgets/menu/repository/aae_menu_repository.dart';
import 'package:aae/common/widgets/placeholder/placeholder_screens.dart';
import 'package:flutter/material.dart';

class AaeDrawer extends StatelessWidget {
  AaeDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //TODO: (rpaglinawan) implement drawer menu instead of jumping right
      //into setting panel
      child: Center(
        child: buildSettingsMenu(context),
      ),
    );
  }

  ListView buildSettingsMenu(BuildContext context) {
    final _routeTable = AaeSettingsMenuRepository.routeTable;
    return ListView.builder(
      itemCount: _routeTable.keys.length,
      itemBuilder: (context, index) {
        String _title = _routeTable.keys.elementAt(index);
        return AaeDrawerComponent(
          menuTitle: _title,
          onPressedMenuSetting: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: _routeTable.values.elementAt(index),
            ),
          ),
        );
      },
    );
  }
}
