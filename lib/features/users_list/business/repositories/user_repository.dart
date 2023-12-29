import 'package:dartz/dartz.dart';
import 'package:suitmedia_test/core/errors/failures.dart';
import 'package:suitmedia_test/features/users_list/business/entities/users_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UsersEntity>> getUsers({
    required int page,
    int perPage = 10,
  });
}
