import 'package:flutter/material.dart';
import 'package:user_profile_management/model/user_model.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.saveFunction,
    this.user,
  });

  final void Function()? saveFunction;
  final User? user;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: saveFunction,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
      ),
      child: Text(
        user == null ? 'Add User' : 'Update User',
        style: const TextStyle(
          color: Colors.deepPurple,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
