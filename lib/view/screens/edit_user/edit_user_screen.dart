import 'package:flutter/material.dart';
import 'package:user_profile_management/model/user_model.dart';

class AddOrUpdateUserScreen extends StatefulWidget {
  final User? user;

  const AddOrUpdateUserScreen({super.key, this.user});

  @override
  State<AddOrUpdateUserScreen> createState() => _AddOrUpdateUserScreenState();
}

class _AddOrUpdateUserScreenState extends State<AddOrUpdateUserScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _name;
  late String _userName;
  late String _email;
  late String _phone;
  late String _website;

  @override
  void initState() {
    super.initState();
    _name = widget.user?.name ?? '';
    _userName = widget.user?.username ?? '';
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
        username: _userName,
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

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.user == null
              ? 'User added successfully!'
              : 'User updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context, {
        'action': widget.user == null ? 'add' : 'edit',
        'user': user,
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields correctly.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user == null ? 'Add User' : 'Edit User'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.person),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a name' : null,
                onSaved: (value) => _name = value!,
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: _userName,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.person_outline),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a username' : null,
                onSaved: (value) => _userName = value!,
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.email),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an email, "example@example.com"';
                  } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: _phone,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.phone),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a phone number';
                  } else if (!RegExp(r'^[0-9]{11}$').hasMatch(value)) {
                    return 'Please enter a valid 11-digit phone number';
                  }
                  return null;
                },
                onSaved: (value) => _phone = value!,
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: _website,
                decoration: InputDecoration(
                  labelText: 'Website',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.link),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a website';
                  }
                  return null;
                },
                onSaved: (value) => _website = value!,
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _saveForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    widget.user == null ? 'Add User' : 'Update User',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
