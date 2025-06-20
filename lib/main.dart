import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/datasources/user_remote_datasource.dart';
import 'data/datasources/post_remote_datasource.dart';
import 'data/repositories/user_repository_impl.dart';
import 'data/repositories/post_repository_impl.dart';
import 'domain/usecases/get_users.dart';
import 'domain/usecases/get_posts_by_user.dart';
import 'presentation/pages/user_list_page.dart';
import 'presentation/providers/user_provider.dart';
import 'presentation/providers/post_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final userRepo = UserRepositoryImpl(UserRemoteDatasource());
    final postRepo = PostRepositoryImpl(PostRemoteDatasource());

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(GetUsers(userRepo))..loadUsers(),
        ),
        ChangeNotifierProvider(
          create: (_) => PostProvider(GetPostsByUser(postRepo)),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'JSONPlaceholder App',
        home: const UserListPage(),
      ),
    );
  }
}
