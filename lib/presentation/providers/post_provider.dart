import 'package:flutter/material.dart';
import '../../domain/entities/post.dart';
import '../../domain/usecases/get_posts_by_user.dart';

class PostProvider extends ChangeNotifier {
  final GetPostsByUser getPostsByUser;

  List<Post> posts = [];
  bool isLoading = false;

  PostProvider(this.getPostsByUser);

  Future<void> loadPosts(int userId) async {
    isLoading = true;
    notifyListeners();

    posts = await getPostsByUser.execute(userId);

    isLoading = false;
    notifyListeners();
  }
}
