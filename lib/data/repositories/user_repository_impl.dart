import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_datasource.dart';
import '../models/user_model.dart';
import 'dart:convert';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource remoteDatasource;

  UserRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<User>> getUsers() async {
    final response = await remoteDatasource.fetchUsers();
    final List<dynamic> data = jsonDecode(response.body);

    return data.map((json) => UserModel.fromJson(json as Map<String, dynamic>)).toList();
  }
}
