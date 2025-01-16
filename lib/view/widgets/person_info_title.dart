import 'package:flutter/material.dart';

class PersonInfoTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData iconData;
  final Function()? onTap;
  const PersonInfoTitle({super.key, required this.title, required this.subtitle, required this.iconData, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        onTap: onTap,
        trailing: onTap == null ? null : OutlinedButton(onPressed: onTap, child: Text('Launch')),
        leading: Icon(iconData),
        title: Text(title,style: TextStyle(fontSize: 16),),
        subtitle: Text(subtitle,style: TextStyle(fontSize: 14),),
      ),
    );
  }
}
