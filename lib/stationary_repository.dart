import 'dart:io';
import 'dart:convert';

import 'package:kuis/stationery_item.dart';

class LocalStationeryItemRepository {
  final File file;

  LocalStationeryItemRepository(this.file);

  Future<void> resetAsync() async {
    await file.writeAsString("[]");
  }

  Future<List<StationeryItem>> getAllAsync() async {
    return await file.readAsString().then((String content) {
      if (content == "") {
        return [];
      }
      final decodedJson = jsonDecode(content);

      List<StationeryItem> foodItems = decodedJson
          .map<StationeryItem>(
            (item) => StationeryItem(
              name: item["name"],
              description: item["description"],
              price: item["price"],
              imageUrl: item["imageUrl"],
              stock: item["stock"],
            ),
          )
          .toList();

      return foodItems;
    });
  }

  Future<void> saveAsync(List<StationeryItem> data) async {
    final foodItemHashmap = data
        .map(
          (item) => <String, dynamic>{
            "name": item.name,
            "description": item.description,
            "price": item.price,
            "imageUrl": item.imageUrl,
            "stock": item.stock,
          },
        )
        .toList();

    final encodedJson = jsonEncode(foodItemHashmap);
    await file.writeAsString(encodedJson);
  }
}
