import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_test/features/users_list/business/entities/user_entity.dart';
import 'package:suitmedia_test/features/welcome/presentation/providers/name_provider.dart';

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
