import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileMethods {
  // Go to user phone caller method
  static callUserPhone({
    required String phoneNumber,
    required BuildContext context,
  }) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      showSnackBar(context: context, text: "Can't open the phone application.");
    }
  }

  // Launch Email method
  static launchEmail(
      {required String email, required BuildContext context}) async {
    const subject = 'Hello';
    const body = 'Test';
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=$subject&body=$body',
    );

    final url = emailLaunchUri.toString();
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      showSnackBar(context: context, text: "Can't launch email");
    }
  }

  // Show snack bar method
  static showSnackBar({required BuildContext context, required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    ));
  }
}
