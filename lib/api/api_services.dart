import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import '../database/collections/food_collection.dart';
import '../database/services/isar_db_service.dart';

class ApiService {
  Future<List<Food>> fetchFoodItems() async {
    IsarService isv = IsarService();
    final existingFoods = await isv.getAllFoods();

    if (existingFoods.isNotEmpty) {
      debugPrint('We already have some items saved in foods collection..');
      return existingFoods;
    } else {
      try {
        final response = await http.get(
          Uri.parse('$baseUrl$getFoodEndPoint?apiKey=$apiKey&number=$foodItemsToGet'),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final foodItems = data['results'] as List<dynamic>;
          //response lacks prices so i will generate myself
          for (var item in foodItems) {
            int price = generateRandomPrice();
            final food = Food(
              id: item['id'],
              title: item['title'],
              image: item['image'],
              price: double.parse(price.toString()),
            );
            await isv.saveFood(food);
          }

          debugPrint('Saved new items to Foods Collection.');
          final addedFoods = await isv.getAllFoods();
          return addedFoods;
        } else {
          throw Exception(
              'Failed to load food items. Status code: ${response.statusCode}');
        }
      } catch (e) {
        throw Exception('Error fetching food items: $e');
      }
    }
  }

  Future checkout() async {
      final response = await http.get(
        Uri.parse('$baseUrl$checkoutEndPoint?apiKey=$apiKey'),
      );
     return response;
  }


  int generateRandomPrice() {
    Random random = Random();
    int rdmMult = random.nextInt(40) + 10;
    return rdmMult * 10;
  }
}
