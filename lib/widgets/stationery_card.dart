import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kuis/pages/stationery_detail_page.dart';
import 'package:kuis/stationary_repository.dart';
import 'package:kuis/stationery_item.dart';

class StationeryCard extends StatelessWidget {
  final String title;
  final String description;
  final int price;
  int quantity;
  final String imageUrl;

  LocalStationeryItemRepository repository;

  Future<void> Function() onDataChanged;

  StationeryCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    required this.repository,
    required this.onDataChanged,
  });

  int _countPrice() => (price * quantity);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StationeryDetailPage(
              item: StationeryItem(
                name: title,
                description: description,
                price: price,
                stock: quantity,
                imageUrl: imageUrl,
              ),
              onSubmit: (stock, price, description) async {
                final currentList = await repository.getAllAsync();

                final updated = currentList.map((item) {
                  if (item.name != title) {
                    return item;
                  }

                  item.stock = stock;
                  item.description = description;
                  item.price = price;

                  return item;
                }).toList();

                print("updated data is $updated");

                await repository.saveAsync(updated);
              },

              repository: repository,
            ),
          ),
        );
        await onDataChanged();
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 150),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight(1000),
                          ),
                        ),
                        Text(
                          description,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "$quantity pcs tersedia",
                                style: TextStyle(color: Colors.blue),
                              ),
                              Text("Rp.$price / pcs"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
