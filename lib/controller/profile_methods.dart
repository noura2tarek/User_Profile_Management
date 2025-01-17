import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class ProfileMethods {

  static callUserPhone({required String phoneNumber, required BuildContext context})async {
    final Uri url = Uri(scheme: 'tel',path: phoneNumber);
    if(await canLaunchUrl(url)){
    await launchUrl(url);
    }else{
      showSnackBar(context: context, text: "Can't open the phone application.");
    }
  }

  static launchWebsite({required String websiteLink, required BuildContext context})async{
    final Uri url = Uri.parse(websiteLink);
    if(await canLaunchUrl(url)){
    await launchUrl(url);
    }else{
      showSnackBar(context: context, text: "Can't open the website.");
    }
  }

  static launchEmail({required String email, required BuildContext context})async{
    final Uri url = Uri.parse('mailto:$email');
    if(await canLaunchUrl(url)){
      await launchUrl(url);
    }else{
      showSnackBar(context: context, text: "Can't launch email");
    }
  }

  static showSnackBar({required BuildContext context, required String text}){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(label: 'Ok', onPressed: (){
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      )
    );
  }

}