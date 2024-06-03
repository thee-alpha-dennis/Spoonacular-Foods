/*
  Author : (Dennis Ongong'a - Kenya)
  Copyright © 2024-present
*/
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../collections/food_collection.dart';

class IsarService {
  late Future<Isar> db;
  IsarService() {
    db=openDB();
  }

  Future<Isar> openDB() async {
    var dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [FoodSchema],
        directory: dir.path,
      );
    }
    return Future.value(Isar.getInstance());
  }

  Future<void> saveFood(Food newFood) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.foods.putSync(newFood));
  }

    Future<List<Food>> getAllFoods() async {
    final isar = await db;
    return await isar.foods.where().findAll();
  }
}
