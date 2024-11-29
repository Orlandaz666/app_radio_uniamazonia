import 'package:app_radio_uniamazonia/constants/constants.dart';
import 'package:app_radio_uniamazonia/ui/widgets/list_drawer.dart';
import 'package:app_radio_uniamazonia/ui/widgets/show_dialog.dart';
import 'package:flutter/material.dart';

class CustomDrawer{
  final Showdialog _showdialog;
  final ListDrawer _listDrawer;

  CustomDrawer(this._showdialog, this._listDrawer);

   customdrawer(BuildContext context) {
    return Drawer(
      backgroundColor: backgroundColor,
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(drawerLogoPath),
                fit: BoxFit.contain,
              ),
              color: backgroundColor,
            ),
            child: Text(''),
          ),
          const SizedBox(height: 20),
          _listDrawer.listitle(
            const Icon(Icons.info_outline_rounded),
            const Text('Acerca de'),
            () => _showdialog.showAboutUsDialog(context),
          ),
          _listDrawer.listitle(
            const Icon(Icons.language),
            const Text('Síguenos'),
            () => _showdialog.showFollowUsDialog(context),
          ),
        ],
      ),
    );
  }
}
