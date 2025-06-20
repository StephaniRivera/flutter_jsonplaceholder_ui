import 'package:http/http.dart' as http;

class UserRemoteDatasource {
  Future<http.Response> fetchUsers() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load users');
    }
  }
}
