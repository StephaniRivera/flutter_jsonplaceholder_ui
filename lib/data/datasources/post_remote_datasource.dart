import 'package:http/http.dart' as http;

class PostRemoteDatasource {
  Future<http.Response> fetchPostsByUser(int userId) async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts?userId=$userId'),
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
