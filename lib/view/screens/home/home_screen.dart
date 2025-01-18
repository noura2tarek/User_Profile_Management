import 'package:flutter/material.dart';
import 'package:user_profile_management/controller/api_service.dart';
import 'package:user_profile_management/model/user_model.dart';
import 'package:user_profile_management/view/widgets/custom_list_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users = [];
  bool isLoading = true;

  Future<void> getData() async {
  users = await ApiService().getUsersData();
  setState(() {
    isLoading = false;
  });
}

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const Color myColor = Color.fromARGB(255, 152, 70, 155);
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.person),
        title: const Text("User List"),
        backgroundColor: myColor,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : users.isEmpty
              ? const Center(child: Text("No users available"))
              : ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (BuildContext context, int index) {
                    final user = users[index];
                    return Dismissible(
                      key: ValueKey(user.id),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        setState(() {
                          users.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${user.name} deleted"),
                          ),
                        );
                      },
                      background: Container(
                        color: const Color.fromARGB(183, 241, 37, 22),
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      child: Card(
                        child: customListTile(user: user, myColor: myColor),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
