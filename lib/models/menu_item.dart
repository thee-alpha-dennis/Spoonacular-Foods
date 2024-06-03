/*
  Author : (Dennis Ongong'a - Kenya)
*/
import 'package:isar/isar.dart';
part 'menu_item.g.dart';

@Collection()
class MenuItem {
  late Id id;
  late String title;
  late String imageUrl;

  MenuItem();

  MenuItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        imageUrl = json['image'];
}
