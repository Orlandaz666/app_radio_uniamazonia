import 'package:app_radio_uniamazonia/constants/constants.dart';
import 'package:app_radio_uniamazonia/services/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Showdialog{
  final UrlLauncher _urlLauncher = UrlLauncher();

  showAboutUsDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: backgroundColor,
            title: const Text(
              'Hecho por:',
              textAlign: TextAlign.center,
            ),
            content: const Text(
              'Oficina de Gestión de Información y Comunicaciones\n'
              'V 1.0.0',
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                  foregroundColor: primaryColor,
                ),
                child: const Text('Cerrar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      ); 
  }

  socialmedia(FaIcon faicon, String url) {
    return GestureDetector(
      onTap: () {
        _urlLauncher.launchURL(url);
      } ,
      child: FaIcon(
        faicon.icon,
        size: 35,
        color: primaryColor,
      ),
    );
  }

showFollowUsDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: backgroundColor,
            title: const Text(
              'Síguenos en:',
              textAlign: TextAlign.center,
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                socialmedia(const FaIcon(FontAwesomeIcons.squareFacebook), facebookUrl),
                const SizedBox(width: 10),
                socialmedia(const FaIcon(FontAwesomeIcons.squareInstagram), instagramUrl),
                const SizedBox(width: 10),
                socialmedia(const FaIcon(FontAwesomeIcons.xTwitter), twitterUrl),
                const SizedBox(width: 10),
                socialmedia(const FaIcon(FontAwesomeIcons.tiktok), tiktokUrl),
                const SizedBox(width: 10),
                socialmedia(const FaIcon(FontAwesomeIcons.globe), websiteUrl),
              ],
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                  foregroundColor: primaryColor,
                ),
                child: const Text('Cerrar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
  }


 

}






