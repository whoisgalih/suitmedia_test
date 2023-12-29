import 'package:flutter/material.dart';
import 'package:suitmedia_test/features/users_list/presentation/widgets/user_list_widget.dart';

class UserListPage extends StatelessWidget {
  static const routeName = "/user-list";

  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: UserListWidget(),
    );
  }
}
