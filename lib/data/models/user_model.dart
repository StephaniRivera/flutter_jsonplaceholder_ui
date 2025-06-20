import '../../domain/entities/user.dart';
import '../../domain/entities/address.dart';
import 'address_model.dart';

class UserModel extends User {
  UserModel({
    required int id,
    required String name,
    required String username,
    required String email,
    required Address address,
  }) : super(
    id: id,
    name: name,
    username: username,
    email: email,
    address: address,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      address: AddressModel.fromJson(json['address']),
    );
  }
}
