import 'package:flutter/material.dart';
import 'package:user_profile_management/model/user_model.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.user,
    required this.color,
    this.onTabEdit,
    this.onTab,
    this.onLongPress,
  });

  final User user;
  final Color color;
  final void Function()? onTabEdit;
  final void Function()? onTab;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTab,
      onLongPress: onLongPress,
      leading: CircleAvatar(
        child: Text(
          user.name[0],
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: IconButton(
        icon: Icon(Icons.edit, color: color),
        onPressed: onTabEdit,
      ),
    );
  }
}
