import 'package:dartz/dartz.dart';
import 'package:suitmedia_test/core/errors/failures.dart';
import 'package:suitmedia_test/core/errors/exceptions.dart';
import 'package:suitmedia_test/features/users_list/business/repositories/user_repository.dart';
import 'package:suitmedia_test/features/users_list/data/datasources/user_remote_data_source.dart';
import 'package:suitmedia_test/features/users_list/data/models/users_model.dart';

class UserRepositoryImplementation implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImplementation({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, UsersModel>> getUsers({
    required int page,
    int perPage = 10,
  }) async {
    try {
      final users = await remoteDataSource.getUsers(
        page: page,
        perPage: perPage,
      );
      return Right(users);
    } on ServerException {
      return Left(ServerFailure(errorMessage: 'Server Error'));
    }
  }
}
