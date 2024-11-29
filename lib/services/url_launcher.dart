import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {

  launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
  
}