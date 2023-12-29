import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_test/features/users_list/business/entities/user_entity.dart';
import 'package:suitmedia_test/features/users_list/presentation/providers/user_list_provider.dart';
import 'package:suitmedia_test/features/users_list/presentation/widgets/user_tile_widget.dart';
import 'package:suitmedia_test/features/welcome/presentation/providers/name_provider.dart';

class UserListWidget extends StatefulWidget {
  const UserListWidget({
    super.key,
  });

  @override
  State<UserListWidget> createState() => _UserListWidgetState();
}

class _UserListWidgetState extends State<UserListWidget> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final UserListProvider userListProvider =
        Provider.of<UserListProvider>(context, listen: false);

    userListProvider.eitherFailureOrUsersEntity();

    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  void _scrollListener() {
    final UserListProvider userListProvider =
        Provider.of<UserListProvider>(context, listen: false);

    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      userListProvider.eitherFailureOrUsersEntity();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ? _androidWidget() : _iosWidget();
  }

  Widget _androidWidget() {
    final UserListProvider userListProvider =
        Provider.of<UserListProvider>(context);

    return RefreshIndicator(
      onRefresh: () async {
        await userListProvider.reset();
      },
      child: ListView.builder(
        itemCount: userListProvider.users.length,
        itemBuilder: (context, index) {
          if (index == userListProvider.users.length) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (userListProvider.failure != null) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: const Center(
                child: Text("Error"),
              ),
            );
          }

          final UserEntity userEntity = userListProvider.users[index];
          return UserTileWidget(userEntity: userEntity);
        },
      ),
    );
  }

  CustomScrollView _iosWidget() {
    final UserListProvider userListProvider =
        Provider.of<UserListProvider>(context);

    return CustomScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: () async {
            await userListProvider.reset();
          },
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index == userListProvider.users.length) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: const Center(
                    child: CupertinoActivityIndicator(),
                  ),
                );
              }

              if (userListProvider.failure != null) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: const Center(
                    child: Text("Error"),
                  ),
                );
              }

              final UserEntity userEntity = userListProvider.users[index];

              return UserTileWidget(userEntity: userEntity);
            },
            childCount: userListProvider.users.length,
          ),
        ),
      ],
    );
  }
}
