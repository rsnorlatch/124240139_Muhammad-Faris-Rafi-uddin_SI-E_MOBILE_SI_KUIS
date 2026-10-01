import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 25,
          children: [
            Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(360),
                  ),
                  child: Icon(Icons.person, size: 75, color: Colors.blue),
                ),

                Text(
                  "Muhammad Faris Rafi'uddin",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight(1000)),
                ),
                Text(
                  "Pemilik toko alat tulis",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),

            Card(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  spacing: 10,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(360),
                      ),
                      child: Icon(Icons.shop, size: 25, color: Colors.blue),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Toko Alat Tulis",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight(1000),
                          ),
                        ),
                        Text(
                          "Kelola stok dan haga barang dagangan anda",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Card(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  spacing: 10,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(360),
                      ),
                      child: Icon(Icons.receipt, size: 25, color: Colors.blue),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Barang unggulan",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight(1000),
                          ),
                        ),
                        Text(
                          "Pulpen, buku alat tulis, dan pensil",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
