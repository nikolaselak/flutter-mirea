import 'package:dio/dio.dart';
import 'package:frontend/models/product.dart';

class ProductApiService {
  final Dio _dio = Dio();
  final String baseUrl = 'http://10.0.2.2:8080';

  ProductApiService();

  // Получение списка продуктов
  Future<List<Product>> fetchProducts() async {
    final response = await _dio.get('$baseUrl/products');

    if (response.statusCode == 200) {
      List<dynamic> jsonData = response.data;
      return jsonData.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Не удалось загрузить продукты.');
    }
  }

  // Добавление нового продукта
  Future<Product> addProduct(Product product) async {
    final response = await _dio.post(
      '$baseUrl/products/create',
      data: product.toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Product.fromJson(response.data);
    } else {
      throw Exception('Не удалось добавить продукт.');
    }
  }

  // Получение продукта по Id
  Future<Product> fetchProductById(int id) async {
    final response = await _dio.get('$baseUrl/products/$id');

    if (response.statusCode == 200) {
      return Product.fromJson(response.data);
    } else {
      throw Exception('Не удалось загрузить продукт');
    }
  }

  // Обновление продукта
  Future<Product> updateProduct(Product product) async {
    final response = await _dio.put(
      '$baseUrl/products/update/${product.id}',
      data: product.toJson(),
    );

    if (response.statusCode == 200) {
      return Product.fromJson(response.data);
    } else {
      throw Exception('Не удалось обновить продукт');
    }
  }

  // Удаление продукта по Id
  Future<void> deleteProduct(int id) async {
    final response = await _dio.delete('$baseUrl/products/delete/$id');

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Не удалось удалить продукт');
    }
  }
}
