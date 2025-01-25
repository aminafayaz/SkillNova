import 'package:flutter/material.dart';

class Explorepage extends StatelessWidget {
  const Explorepage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // specify the number of items
                itemBuilder: (context, index) {
                  return Container(
                    height: 100,
                    margin: EdgeInsets.all(8.0),
                    color: Colors.blue,
                    child: Center(
                      child: Text(
                        'Item $index',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}