import '../entities/post.dart';
import '../repositories/ post_repository.dart';


class GetPostsByUser {
  final PostRepository repository;

  GetPostsByUser(this.repository);

  Future<List<Post>> execute(int userId) {
    return repository.getPostsByUser(userId);
  }
}
