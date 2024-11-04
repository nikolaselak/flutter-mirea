import 'package:dio/dio.dart';
import '../models/item_class.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<ItemClass>> getItems() async {
    try {
      final response = await _dio.get('http://10.0.2.2:8080/items');
      if (response.statusCode == 200) {
        List<ItemClass> items = (response.data as List)
            .map((item) => ItemClass.fromJson(item))
            .toList();
        return items;
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      throw Exception('Error fetching items: $e');
    }
  }
}
