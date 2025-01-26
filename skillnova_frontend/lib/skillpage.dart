import 'package:flutter/material.dart';
import 'package:skillnova_frontend/settings.dart';

class SkillPage extends StatefulWidget {
  @override
  _SkillPageState createState() => _SkillPageState();
}

class _SkillPageState extends State<SkillPage> {
  final List<Map<String, String>> _skills = [
    {
      'skill': 'Watercolour Painting',
      'description': 'Learn the art of watercolour painting.',
      'proficiency': 'Intermediate'
    },
    {
      'skill': 'Yoga',
      'description': 'Practice yoga for a healthy mind and body.',
      'proficiency': 'Advanced'
    },
    // Add more skills here
  ];

  final TextEditingController _skillController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedProficiency;

  void _addSkill() {
    if (_skillController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _selectedProficiency != null) {
      setState(() {
        _skills.add({
          'skill': _skillController.text,
          'description': _descriptionController.text,
          'proficiency': _selectedProficiency!,
        });
        _skillController.clear();
        _descriptionController.clear();
        _selectedProficiency = null;
      });
      Navigator.of(context).pop(); // Close the overlay
    }
  }

  void _showAddSkillOverlay(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Skill'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _skillController,
                decoration: InputDecoration(labelText: 'Skill'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              DropdownButton<String>(
                value: _selectedProficiency,
                hint: Text('Select Proficiency'),
                items: ['Beginner', 'Intermediate', 'Advanced', 'Expert']
                    .map((proficiency) => DropdownMenuItem(
                          value: proficiency,
                          child: Text(proficiency),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedProficiency = value;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the overlay
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _addSkill,
              child: Text('Add Skill'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Skills'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _skills.length,
                itemBuilder: (context, index) {
                  final skill = _skills[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          skill['skill']!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text('Description: ${skill['description']}'),
                        SizedBox(height: 5),
                        Text('Proficiency: ${skill['proficiency']}'),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _showAddSkillOverlay(context),
              child: Text('Add Skill'),
            ),
          ],
        ),
      ),
    );
  }
}
