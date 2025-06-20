import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/user.dart';
import '../providers/post_provider.dart';
import '../widget/post_card.dart';

class UserDetailPage extends StatefulWidget {
  final User user;

  const UserDetailPage({required this.user, super.key});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final postProvider = Provider.of<PostProvider>(context, listen: false);
      postProvider.loadPosts(widget.user.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.user.name)),
      body: postProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
        children: postProvider.posts
            .map((post) => PostCard(post: post))
            .toList(),
      ),
    );
  }
}
