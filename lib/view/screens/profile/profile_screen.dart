import 'package:flutter/material.dart';
import 'package:user_profile_management/controller/profile_methods.dart';
import 'package:user_profile_management/model/user_model.dart';
import 'package:user_profile_management/view/widgets/person_info_title.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    const Color myColor = Color.fromARGB(255, 152, 70, 155);

    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
        backgroundColor: myColor,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.account_circle,
                  size: MediaQuery.sizeOf(context).width * 0.4),
              PersonInfoTitle(
                  title: 'ID',
                  subtitle: user.id.toString(),
                  iconData: Icons.numbers),
              PersonInfoTitle(
                  title: 'Name', subtitle: user.name, iconData: Icons.person),
              PersonInfoTitle(
                  title: 'Username',
                  subtitle: user.username,
                  iconData: Icons.manage_accounts_rounded),
              PersonInfoTitle(
                title: 'email',
                subtitle: user.email,
                iconData: Icons.mail,
                onTap: () => ProfileMethods.launchEmail(
                    email: user.email, context: context),
              ),
              PersonInfoTitle(
                title: 'Phone',
                subtitle: user.phone,
                iconData: Icons.phone,
                onTap: () => ProfileMethods.callUserPhone(
                    phoneNumber: user.phone, context: context),
              ),
              PersonInfoTitle(
                title: 'Website',
                subtitle: user.website,
                iconData: Icons.language,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
