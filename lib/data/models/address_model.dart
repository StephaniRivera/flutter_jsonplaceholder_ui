import '../../domain/entities/address.dart';

class AddressModel extends Address {
  AddressModel({
    required String street,
    required String suite,
    required String city,
    required String zipcode,
  }) : super(
    street: street,
    suite: suite,
    city: city,
    zipcode: zipcode,
  );

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      street: json['street'],
      suite: json['suite'],
      city: json['city'],
      zipcode: json['zipcode'],
    );
  }
}
