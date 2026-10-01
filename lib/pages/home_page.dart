import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kuis/stationary_repository.dart';
import 'package:kuis/stationery_item.dart';
import 'package:kuis/widgets/stationery_card.dart';
import 'package:path_provider/path_provider.dart';

class MenuPage extends StatefulWidget {
  MenuPage({super.key});

  @override
  State<StatefulWidget> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late LocalStationeryItemRepository repository;

  List<StationeryItem> items = [];
  bool isLoading = true;

  Future<void> _loadItemsAsync() async {
    final Directory appDocumentDir = await getApplicationDocumentsDirectory();

    final file = File("${appDocumentDir.path}/data/data.json");

    if (!(await file.exists())) await file.create(recursive: true);

    repository = LocalStationeryItemRepository(file);

    if ((await repository.getAllAsync()).isEmpty) {
      await repository.saveAsync(StationeryItem.sampleData);
    }

    try {
      items = await repository.getAllAsync();
      isLoading = false;
    } catch (e) {
      print("failed to load items $e");
    }
  }

  Future<void> refresh() async {
    final fresh = await repository.getAllAsync();

    items = fresh;

    if (!mounted) return;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _loadItemsAsync().then((_) {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Center(child: CircularProgressIndicator(color: Colors.blue)),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        spacing: 18,
        children: items.map((stationeryItem) {
          return StationeryCard(
            title: stationeryItem.name,
            description: stationeryItem.description,
            price: stationeryItem.price,
            quantity: stationeryItem.stock,
            imageUrl: stationeryItem.imageUrl,
            repository: repository,
            onDataChanged: refresh,
          );
        }).toList(),
      ),
    );
  }
}
