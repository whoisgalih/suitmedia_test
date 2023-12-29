import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_test/features/users_list/presentation/providers/user_list_provider.dart';

class UserListWidget extends StatefulWidget {
  const UserListWidget({
    super.key,
  });

  @override
  State<UserListWidget> createState() => _UserListWidgetState();
}

class _UserListWidgetState extends State<UserListWidget> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserListProvider>(context, listen: false)
        .eitherFailureOrUsersEntity();
  }

  @override
  Widget build(BuildContext context) {
    UserListProvider userListProvider = Provider.of<UserListProvider>(context);
    print(userListProvider.usersEntity);

    return Platform.isAndroid ? _androidWidget() : _iosWidget();
  }

  Widget _androidWidget() {
    return RefreshIndicator(
      onRefresh: () async {
        print("refresh");
      },
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => ListTile(
          title: Text("User $index"),
          onTap: () {
            Navigator.pop(context, "User $index");
          },
        ),
      ),
    );
  }

  CustomScrollView _iosWidget() {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: () async {
            print("refresh");
          },
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(
              title: Text("User $index"),
              onTap: () {
                Navigator.pop(context, "User $index");
              },
            ),
            childCount: 10,
          ),
        ),
      ],
    );
  }
}
