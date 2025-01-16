import 'package:flutter/material.dart';
import 'package:user_profile_management/view/screens/profile/profile_screen.dart';

import 'model/user_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ProfileScreen(user: User(id: 123, name: 'John Doe', username: 'johndoe', email: 'john.doe@example.com', phone: '1234567890', website: 'www.example.com', address: Address(street: 'street', suite: 'suite', city: 'city', zipcode: 'zipcode', geo: Geo(lat: '2', lng: '3')), company: Company(name: 'name', catchPhrase: 'catchPhrase', bs: 'bs')),),
    );
  }
}

