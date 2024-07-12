import 'package:ecommerce/src/features/admin/service/admin_service.dart';
import 'package:ecommerce/src/shared/model/user_model.dart';
import 'package:flutter/material.dart';

class ViewAllUsersScreen extends StatefulWidget {
  const ViewAllUsersScreen({super.key});

  @override
  State<ViewAllUsersScreen> createState() => _ViewAllUsersScreenState();
}

class _ViewAllUsersScreenState extends State<ViewAllUsersScreen> {
  List<UserModel> usersList = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    usersList = await AdminService.instance.fetchAllUsers();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: ListView.builder(
        itemCount: usersList.length,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(
            radius: 25,
            child: Text(
              usersList[index].name[0],
              style: const TextStyle(fontSize: 20),
            ),
          ),
          title: Text(usersList[index].name),
          subtitle: Text(usersList[index].emailId),
        ),
      ),
    );
  }
}
