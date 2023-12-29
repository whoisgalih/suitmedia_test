import 'user_entity.dart';

class UsersEntity {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final List<UserEntity> data;
  final SupportEntity support;

  UsersEntity({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
    required this.support,
  });
}
