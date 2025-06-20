import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_users.dart';

class UserProvider extends ChangeNotifier {
  final GetUsers getUsers;

  List<User> users = [];
  bool isLoading = false;

  UserProvider(this.getUsers);

  Future<void> loadUsers() async {
    isLoading = true;
    notifyListeners();

    users = await getUsers.execute();

    isLoading = false;
    notifyListeners();
  }
}
