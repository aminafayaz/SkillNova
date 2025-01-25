import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  final List<Map<String, String>> skills = [
    {'name': 'Watercolour Painting', 'description': 'Learn the art of watercolour painting.'},
    {'name': 'Yoga', 'description': 'Practice yoga for a healthy mind and body.'},
    {'name': 'Fix Bicycles', 'description': 'Learn to repair and maintain bicycles.'},
    {'name': 'Cooking', 'description': 'Master the art of cooking delicious meals.'},
    {'name': 'Gardening', 'description': 'Grow your own plants and vegetables.'},
    {'name': 'Photography', 'description': 'Capture stunning photos with your camera.'},
    {'name': 'Woodworking', 'description': 'Create beautiful wooden crafts and furniture.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore Skills'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search skills...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: skills.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 100,
                    margin: EdgeInsets.all(8.0),
                    color: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            skills[index]['name']!,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            skills[index]['description']!,
                            style: TextStyle(color: Colors.white, fontSize: 16),
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
    );
  }
}