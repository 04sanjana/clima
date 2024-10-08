import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;

  Future<Map<String, dynamic>?> getData() async {
    try {
      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        print('Error: ${response.statusCode}');
        return null; // or handle it as needed
      }
    } catch (e) {
      print('Failed to fetch data: $e');
      return null; // or handle it as needed
    }
  }
}
