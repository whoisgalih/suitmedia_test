import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:suitmedia_test/core/errors/failures.dart';
import 'package:suitmedia_test/features/users_list/business/entities/users_entity.dart';
import 'package:suitmedia_test/features/users_list/business/usecases/get_users.dart';
import 'package:suitmedia_test/features/users_list/data/datasources/user_remote_data_source.dart';
import 'package:suitmedia_test/features/users_list/data/repositories/user_repository_implementation.dart';

class UserListProvider extends ChangeNotifier {
  UsersEntity? usersEntity;
  Failure? failure;

  void eitherFailureOrUsersEntity() async {
    UserRepositoryImplementation repository = UserRepositoryImplementation(
      remoteDataSource: UserRemoteDataSourceImplementation(
        dio: Dio(),
      ),
    );

    final failureOrUsersEntity = await GetUsers(repository).call();

    failureOrUsersEntity.fold(
      (failure) {
        failure = failure;
        usersEntity = null;
        notifyListeners();
      },
      (users) {
        usersEntity = users;
        failure = null;
        notifyListeners();
      },
    );
  }
}
