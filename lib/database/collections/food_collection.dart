/*
  Author : (Dennis Ongong'a - Kenya)
  Copyright © 2024-present
*/
import 'package:isar/isar.dart';

part 'food_collection.g.dart';

@collection
class Food {
  final Id id;
  final String title;
  final String image;
  final double price;

  Food({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
  });
}