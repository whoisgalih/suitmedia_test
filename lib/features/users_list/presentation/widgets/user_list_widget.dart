import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_test/features/users_list/business/entities/user_entity.dart';
import 'package:suitmedia_test/features/users_list/presentation/providers/user_list_provider.dart';
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
          final UserEntity userEntity = userListProvider.users[index];
          return ListTile(
            title: Text("User ${userEntity.id}"),
          );
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

class UserTileWidget extends StatelessWidget {
  const UserTileWidget({
    super.key,
    required this.userEntity,
  });

  final UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Provider.of<NameProvider>(context, listen: false).user = userEntity;
          Navigator.pop(context);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              Container(
                width: 64,
                height: 64,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Image.network(
                  userEntity.avatar,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return const CupertinoActivityIndicator();
                  },
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${userEntity.firstName} ${userEntity.lastName}",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    userEntity.email,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
