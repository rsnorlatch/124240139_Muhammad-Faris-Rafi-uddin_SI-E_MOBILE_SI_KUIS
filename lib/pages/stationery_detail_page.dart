import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kuis/stationary_repository.dart';
import 'package:kuis/stationery_item.dart';

class StationeryDetailPage extends StatefulWidget {
  StationeryDetailPage({
    required this.repository,
    required this.item,
    required this.onSubmit,
    super.key,
  });

  LocalStationeryItemRepository repository;

  final StationeryItem item;
  void Function(int, int, String) onSubmit;

  @override
  State<StatefulWidget> createState() => _StationeryDetailPageState(
    repository: repository,
    item: item,
    onSubmit: onSubmit,
  );
}

class _StationeryDetailPageState extends State<StationeryDetailPage> {
  _StationeryDetailPageState({
    required this.repository,
    required this.item,
    required this.onSubmit,
  });

  LocalStationeryItemRepository repository;
  StationeryItem item;
  void Function(int, int, String) onSubmit;

  final _quantityController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  var total = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.blue,
        title: Text("Detail Menu", style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        spacing: 10,
        children: [
          Card(child: Image.network(item.imageUrl)),
          Card(
            child: Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight(1000),
                    ),
                  ),
                  Text(
                    "Rp. ${item.price} / pcs",
                    style: TextStyle(color: Colors.green, fontSize: 12),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: _quantityController,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) {
                      setState(() {
                        try {
                          total = int.parse(value) * item.price;
                        } catch (_) {
                          total = 0;
                        }
                      });
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.list),
                      iconColor: Colors.grey,
                      hint: Text("stock"),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.receipt),
                      iconColor: Colors.grey,
                      hint: Text("descripion"),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                  ),

                  TextField(
                    keyboardType: TextInputType.number,
                    controller: _priceController,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      icon: Icon(Icons.money),
                      iconColor: Colors.grey,
                      hint: Text("price"),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: EdgeInsets.all(20),
            ),
            onPressed: () {
              Navigator.pop(context);
              try {
                onSubmit(
                  int.parse(_quantityController.text),
                  int.parse(_priceController.text),
                  _descriptionController.text,
                );
              } catch (_) {
                print("something went terribly wrong");
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: Colors.white),
                Text("Simpan Pesanan", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
