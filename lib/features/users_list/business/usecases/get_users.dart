import 'package:dartz/dartz.dart';
import 'package:suitmedia_test/core/errors/failures.dart';
import 'package:suitmedia_test/features/users_list/business/entities/users_entity.dart';
import 'package:suitmedia_test/features/users_list/business/repositories/user_repository.dart';

class GetUsers {
  final UserRepository repository;

  GetUsers(this.repository);

  Future<Either<Failure, UsersEntity>> call() async {
    return await repository.getUsers();
  }
}
