import 'package:flutter/material.dart';
import 'package:user_profile_management/model/user_model.dart';

class AddOrUpdateUserScreen extends StatefulWidget {
  final User? user;
  const AddOrUpdateUserScreen({super.key, this.user});

  @override
  State<AddOrUpdateUserScreen> createState() => _AddOrUpdateUserScreenState();
}

class _AddOrUpdateUserScreenState extends State<AddOrUpdateUserScreen> {
  final _formkey = GlobalKey<FormState>();

  late String _name;
  late String _userName;
  late String _email;
  late String _phone;
  late String _website;
  @override
  void initState() {
    super.initState();
    //Initialization with exisisting user data if it was an edit or empty strings for a new user
    _name = widget.user?.name ?? '';
    _userName = widget.user?.username ?? '';
    _email = widget.user?.email ?? '';
    _phone = widget.user?.phone ?? '';
    _website = widget.user?.website ?? '';
  }

  void _saveForm() {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();

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
          geo: Geo(
            lat: '',
            lng: '',
          ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user == null ? 'Add User' : 'Edit User'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'User',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a name' : null,
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                initialValue: _userName,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a username' : null,
                onSaved: (value) => _userName = value!,
              ),
              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter an email' : null,
                onSaved: (value) => _email = value!,
              ),
              TextFormField(
                initialValue: _phone,
                decoration: InputDecoration(labelText: 'Phone'),
                onSaved: (value) => _phone = value!,
              ),
              TextFormField(
                initialValue: _website,
                decoration: InputDecoration(labelText: 'Website'),
                onSaved: (value) => _website = value!,
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: _saveForm,
                  child: Text(widget.user == null ? 'Add User' : 'Update User'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
