import '../entities/post.dart';

abstract class PostRepository {
  Future<List<Post>> getPostsByUser(int userId);
}
