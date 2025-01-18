import 'package:flutter/material.dart';
import 'package:user_profile_management/model/user_model.dart';
import 'package:user_profile_management/view/widgets/custom_form_field.dart';

class AddOrUpdateUserScreen extends StatefulWidget {
  final User? user;

  const AddOrUpdateUserScreen({super.key, this.user});

  @override
  State<AddOrUpdateUserScreen> createState() => _AddOrUpdateUserScreenState();
}

class _AddOrUpdateUserScreenState extends State<AddOrUpdateUserScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _username;
  late String _email;
  late String _phone;
  late String _website;

  @override
  void initState() {
    super.initState();
    _name = widget.user?.name ?? '';
    _username = widget.user?.username ?? '';
    _email = widget.user?.email ?? '';
    _phone = widget.user?.phone ?? '';
    _website = widget.user?.website ?? '';
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final user = User(
        id: widget.user?.id ?? 0,
        name: _name,
        username: _username,
        email: _email,
        phone: _phone,
        website: _website,
        address: Address(
          street: '',
          suite: '',
          city: '',
          zipcode: '',
          geo: Geo(lat: '', lng: ''),
        ),
        company: Company(
          name: '',
          catchPhrase: '',
          bs: '',
        ),
      );

      Navigator.pop(context, {
        'action': widget.user == null ? 'add' : 'edit',
        'user': user,
      });
    }
  }

  // Email validation regex
  bool _validateEmail(String email) {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  // Phone validation regex
  bool _validatePhone(String phone) {
    final regex = RegExp(r'^[0-9]{11}$');
    return regex.hasMatch(phone);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.purpleAccent,
                Colors.deepPurpleAccent,
                Colors.deepPurpleAccent
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.user == null ? 'Add User' : 'Edit User',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                //---- Name form field ----//
                CustomFormField(
                  initialValue: _name,
                  labelName: 'Name',
                  prefixIcon: Icons.person,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a name' : null,
                  onSaved: (value) => _name = value!,
                ),
                const SizedBox(height: 16),
                //---- User name form field ----//
                CustomFormField(
                  initialValue: _username,
                  labelName: 'Username',
                  prefixIcon: Icons.person_outline,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a username' : null,
                  onSaved: (value) => _username = value!,
                ),
                const SizedBox(height: 16),
                //---- Email form field ----//
                CustomFormField(
                  initialValue: _email,
                  labelName: 'Email',
                  prefixIcon: Icons.email,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an email';
                    }
                    if (!_validateEmail(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onSaved: (value) => _email = value!,
                ),
                const SizedBox(height: 16),
                //---- Phone form field ----//
                CustomFormField(
                  initialValue: _phone,
                  labelName: 'Phone',
                  prefixIcon: Icons.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a phone number';
                    }
                    if (!_validatePhone(value)) {
                      return 'Please enter a valid 11-digit phone number';
                    }
                    return null;
                  },
                  onSaved: (value) => _phone = value!,
                ),
                const SizedBox(height: 16),
                //---- Website form field ----//
                CustomFormField(
                  initialValue: _website,
                  labelName: 'Website',
                  prefixIcon: Icons.web,
                  onSaved: (value) => _website = value!,
                ),
                const SizedBox(height: 20),
                //---- Update or Add Button ----//
                ElevatedButton(
                  onPressed: _saveForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                    widget.user == null ? 'Add User' : 'Update User',
                    style: const TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
