import 'package:flutter/material.dart';
import 'chat_page.dart';

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

  final int availableCredits = 100; // Example value for available credits
  final Map<String, List<Map<String, String>>> usersBySkill = {
    'Watercolour Painting': [
      {'name': 'Alice', 'proficiency': 'Intermediate'},
      {'name': 'Bob', 'proficiency': 'Beginner'},
    ],
    'Yoga': [
      {'name': 'Charlie', 'proficiency': 'Advanced'},
      {'name': 'Dave', 'proficiency': 'Intermediate'},
    ],
    'Fix Bicycles': [
      {'name': 'Eve', 'proficiency': 'Expert'},
      {'name': 'Frank', 'proficiency': 'Intermediate'},
    ],
    'Cooking': [
      {'name': 'Grace', 'proficiency': 'Expert'},
      {'name': 'Heidi', 'proficiency': 'Beginner'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore Skills'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Credits: $availableCredits',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: skills.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(skills[index]['name']!),
            subtitle: Text(skills[index]['description']!),
            children: usersBySkill[skills[index]['name']]!.map((user) {
              return ListTile(
                title: Text(user['name']!),
                subtitle: Text('Proficiency: ${user['proficiency']}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(
                        userName: user['name']!,
                        userCredits: availableCredits,
                        skillProviderCredits: 0, // Initial credits for skill provider
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
