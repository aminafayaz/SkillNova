import 'package:flutter/material.dart';
import 'package:skillnova_frontend/globals.dart' as globals;
import 'skill_detail_page.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final List<Map<String, String>> skills = [
    {'name': 'Watercolour Painting', 'description': 'Learn the art of watercolour painting.'},
    {'name': 'Yoga', 'description': 'Practice yoga for a healthy mind and body.'},
    {'name': 'Fix Bicycles', 'description': 'Learn to repair and maintain bicycles.'},
    {'name': 'Cooking', 'description': 'Master the art of cooking delicious meals.'},
    {'name': 'Gardening', 'description': 'Grow your own plants and vegetables.'},
    {'name': 'Photography', 'description': 'Capture stunning photos with your camera.'},
    {'name': 'Woodworking', 'description': 'Create beautiful wooden crafts and furniture.'},
  ];

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
      {'name': 'Heidi', 'proficiency': 'Advanced'},
    ],
    'Gardening': [
      {'name': 'Ivan', 'proficiency': 'Beginner'},
      {'name': 'Judy', 'proficiency': 'Intermediate'},
    ],
    'Photography': [
      {'name': 'Mallory', 'proficiency': 'Advanced'},
      {'name': 'Niaj', 'proficiency': 'Beginner'},
    ],
    'Woodworking': [
      {'name': 'Ruby', 'proficiency': 'Intermediate'},
      {'name': 'Lily', 'proficiency': 'Beginner'},
    ],
  };

  void _endChat(String proficiency) {
    int cost = 0;
    switch (proficiency) {
      case 'Beginner':
        cost = 100;
        break;
      case 'Intermediate':
        cost = 500;
        break;
      case 'Advanced':
        cost = 1000;
        break;
      case 'Expert':
        cost = 1500;
        break;
    }
    setState(() {
      globals.remainingCredits  -= cost;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore Skills'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Remaining Credits: ${globals.remainingCredits}'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: skills.length,
              itemBuilder: (context, index) {
                final skill = skills[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(skill['name']!),
                    subtitle: Text(skill['description']!),
                    onTap: () {
                      final requiredCredits = 100; // Example required credits for accessing a skill
                      if (globals.remainingCredits < requiredCredits) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Not enough credits'),
                              content: Text('Offer help and earn credits first.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SkillDetailPage(
                              skillName: skill['name']!,
                              users: usersBySkill[skill['name']]!,
                              endChatCallback: _endChat,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
