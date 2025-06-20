import '../../domain/entities/post.dart';
import '../../domain/repositories/ post_repository.dart';
import '../datasources/post_remote_datasource.dart';
import '../models/post_model.dart';
import 'dart:convert';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDatasource remoteDatasource;

  PostRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<Post>> getPostsByUser(int userId) async {
    final response = await remoteDatasource.fetchPostsByUser(userId);
    final List<dynamic> data = jsonDecode(response.body);

    return data.map((json) => PostModel.fromJson(json)).toList();
  }
}
