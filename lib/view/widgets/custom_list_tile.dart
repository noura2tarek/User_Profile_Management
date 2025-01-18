import 'package:flutter/material.dart';
import 'package:user_profile_management/model/user_model.dart';

class customListTile extends StatelessWidget {
  const customListTile({
    super.key,
    required this.user,
    required this.myColor,
  });

  final User user;
  final Color myColor;

  @override
  Widget build(BuildContext context) {
  const Color myColor = Color.fromARGB(255, 152, 70, 155);
    return ListTile(
      leading: CircleAvatar(
        child: Text(
          user.name[0],
          style: TextStyle(
            color: myColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: IconButton(icon: const Icon(Icons.edit, color: myColor),
            onPressed: () {},
          ),
    );
  }
}
