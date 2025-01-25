import 'package:flutter/material.dart';

class SkillPage extends StatefulWidget {
  @override
  _SkillPageState createState() => _SkillPageState();
}

class _SkillPageState extends State<SkillPage> {
  final TextEditingController _skillController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _proficiencyController = TextEditingController();
  final List<String> _skills = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Add Your Skills'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // Show the list of added skills
            Expanded(
              child: ListView.builder(
                itemCount: _skills.length,
                itemBuilder: (context, index) => ListTile(
                  leading: Icon(Icons.check),
                  title: Text(_skills[index]),
                ),
              ),
            ),
            SizedBox(height: 16),
            // Button to open overlay
            ElevatedButton(
              onPressed: () => _showAddSkillDialog(context),
              child: Text('Add Skill'),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showAddSkillDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text('Add a Skill'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _skillController,
                decoration: InputDecoration(
                  labelText: 'Enter your skill',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _experienceController,
                decoration: InputDecoration(
                  labelText: 'Enter your experience',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _proficiencyController,
                decoration: InputDecoration(
                  labelText: 'Enter your proficiency',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add your save functionality here
                },
                child: Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }
}
