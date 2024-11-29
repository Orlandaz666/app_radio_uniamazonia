import 'package:app_radio_uniamazonia/constants/constants.dart';
import 'package:flutter/material.dart';

class ListDrawer {
  
  listitle(Icon icon, Text text, method) {
    return ListTile(
      leading: Icon(
        icon.icon,
        color: primaryColor,
        size: 30,
      ),
      title: text,
      onTap: () {
        method();
      },
    );
  }


}