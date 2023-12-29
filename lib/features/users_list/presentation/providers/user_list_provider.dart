import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:suitmedia_test/core/errors/failures.dart';
import 'package:suitmedia_test/features/users_list/business/entities/user_entity.dart';
import 'package:suitmedia_test/features/users_list/business/usecases/get_users.dart';
import 'package:suitmedia_test/features/users_list/data/datasources/user_remote_data_source.dart';
import 'package:suitmedia_test/features/users_list/data/repositories/user_repository_implementation.dart';

class UserListProvider extends ChangeNotifier {
  ScrollController scrollController = ScrollController();

  Failure? failure;

  int page = 1;
  bool last = false;
  List<UserEntity> _users = [];

  List<UserEntity> get users => _users;

  Future<void> reset() async {
    page = 1;
    _users = [];
    await eitherFailureOrUsersEntity();
  }

  Future<void> eitherFailureOrUsersEntity() async {
    UserRepositoryImplementation repository = UserRepositoryImplementation(
      remoteDataSource: UserRemoteDataSourceImplementation(
        dio: Dio(),
      ),
    );

    final failureOrUsersEntity = await GetUsers(repository).call(
      page: page,
    );

    failureOrUsersEntity.fold(
      (failure) {
        failure = failure;
        notifyListeners();
      },
      (users) {
        _users.addAll(users.data);
        page++;
        notifyListeners();

        failure = null;
        notifyListeners();
      },
    );
  }
}
