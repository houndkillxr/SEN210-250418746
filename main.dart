import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(BrewAndChillApp());
}

class BrewAndChillApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Brew & Chill',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF5F1EE),
      ),
      home: HomeScreen(),
    );
  }
}

class Cafe {
  String name;
  double rating;
  String busy;
  String noise;
  int tables;

  Cafe({
    required this.name,
    required this.rating,
    required this.busy,
    required this.noise,
    required this.tables,
  });
}

final random = Random();

List<Cafe> cafes = [
  Cafe(name: "Espresso Lab", rating: 4.9, busy: "Busy", noise: "Loud", tables: random.nextInt(50) + 1),
  Cafe(name: "Florida Cafe", rating: 4.7, busy: "Calm", noise: "Silent", tables: random.nextInt(50) + 1),
  Cafe(name: "Coffy", rating: 4.2, busy: "Moderate", noise: "Medium", tables: random.nextInt(50) + 1),
  Cafe(name: "Caffe Schutz", rating: 4.6, busy: "Busy", noise: "Medium", tables: random.nextInt(50) + 1),
];

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchText = "";

  Color busyColor(String busy) {
    if (busy == "Busy") return Colors.red;
    if (busy == "Moderate") return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    List<Cafe> filteredCafes = cafes.where((cafe) => cafe.name.toLowerCase().contains(searchText.toLowerCase())).toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Color(0xFFEDE3DC),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Brew&Chill",
                    style: TextStyle(
                      color: Color(0xFF5C4033),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.coffee, size: 14, color: Colors.brown),
                      SizedBox(width: 4),
                      Text(
                        "find your perfect bean",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Search cafes...",
                        prefixIcon: Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredCafes.length,
                        itemBuilder: (context, index) {
                          final cafe = filteredCafes[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => DetailsScreen(cafe: cafe)),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 15),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 6,
                                    color: Colors.black12,
                                    offset: Offset(0, 3),
                                  )
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFEEE6E1),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Icon(Icons.local_cafe, color: Colors.brown),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cafe.name,
                                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "Perfect for studying",
                                          style: TextStyle(fontSize: 12, color: Colors.grey),
                                        ),
                                        SizedBox(height: 6),
                                        Row(
                                          children: [
                                            Icon(Icons.star, size: 16, color: Colors.amber),
                                            SizedBox(width: 5),
                                            Text("${cafe.rating} / 5"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: busyColor(cafe.busy),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(cafe.busy, style: TextStyle(color: Colors.white, fontSize: 12)),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
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

class DetailsScreen extends StatelessWidget {
  final Cafe cafe;
  DetailsScreen({required this.cafe});

  Color busyColor(String busy) {
    if (busy == "Busy") return Colors.red;
    if (busy == "Moderate") return Colors.orange;
    return Colors.green;
  }

  IconData noiseIcon(String noise) {
    if (noise == "Loud") return Icons.volume_up;
    if (noise == "Medium") return Icons.volume_down;
    return Icons.volume_off;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(cafe.name), backgroundColor: Colors.brown),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(cafe.name, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  SizedBox(width: 10),
                  Text("Rating: ${cafe.rating}"),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(color: busyColor(cafe.busy), borderRadius: BorderRadius.circular(15)),
              child: Text("Busy: ${cafe.busy}", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  Icon(noiseIcon(cafe.noise)),
                  SizedBox(width: 10),
                  Text("Noise: ${cafe.noise}"),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  Icon(Icons.event_seat, color: Colors.brown),
                  SizedBox(width: 10),
                  Text("Tables available: ${cafe.tables}"),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text("Reviews", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Text("Great place to study, very calm."),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Text("Coffee is amazing but gets busy fast."),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Text("Perfect vibe for working on assignments."),
            ),
          ],
        ),
      ),
    );
  }
}