import 'package:dio/dio.dart';
import 'package:suitmedia_test/core/constants/constants.dart';
import 'package:suitmedia_test/features/users_list/data/models/users_model.dart';

abstract class UserRemoteDataSource {
  Future<UsersModel> getUsers();
}

class UserRemoteDataSourceImplementation implements UserRemoteDataSource {
  final Dio dio;

  UserRemoteDataSourceImplementation({
    required this.dio,
  });

  @override
  Future<UsersModel> getUsers() async {
    final Response response = await dio.get('$baseUrl/users');
    final UsersModel users = UsersModel.fromJson(response.data);
    return users;
  }
}
