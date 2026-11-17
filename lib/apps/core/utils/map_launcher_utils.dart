import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class MapLauncherUtils {
  static Future<bool> launchCoordinates({
    required double latitude,
    required double longitude,
    String? title,
  }) async {
    final query = '$latitude,$longitude';
    Uri uri;

    if (Platform.isAndroid) {
      uri = Uri.parse('geo:$query?q=$query${title != null ? '($title)' : ''}');
    } else if (Platform.isIOS) {
      uri = Uri.parse('maps://?q=$query');
    } else {
      uri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$query');
    }

    try {
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}

    // Fallback to Google Maps web in browser
    final fallbackUri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$query',
    );
    try {
      if (await canLaunchUrl(fallbackUri)) {
        return await launchUrl(
          fallbackUri,
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (_) {}

    return false;
  }
}
