import 'package:flutter/material.dart';
import 'skill_detail_page.dart';

class ExplorePage extends StatefulWidget {
  final int creditPoints;
  final Function(int) updateCreditPoints;

  ExplorePage({required this.creditPoints, required this.updateCreditPoints});

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
  };

  void _updateCredits(String proficiency, bool isHelping) {
    int points = 0;
    switch (proficiency) {
      case 'Beginner':
        points = 100;
        break;
      case 'Intermediate':
        points = 500;
        break;
      case 'Advanced':
        points = 1000;
        break;
      case 'Expert':
        points = 1500;
        break;
    }
    widget.updateCreditPoints(isHelping ? points : -points);
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
            child: Text('Credit Points: ${widget.creditPoints}'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: skills.length,
              itemBuilder: (context, index) {
                final skill = skills[index];
                return ListTile(
                  title: Text(skill['name']!),
                  subtitle: Text(skill['description']!),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SkillDetailPage(
                          skillName: skill['name']!,
                          users: usersBySkill[skill['name']]!,
                          updateCreditsCallback: _updateCredits,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
