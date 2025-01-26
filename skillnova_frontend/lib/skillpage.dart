import 'package:flutter/material.dart';

class SkillPage extends StatefulWidget {
  const SkillPage({Key? key}) : super(key: key);

  @override
  _SkillPageState createState() => _SkillPageState();
}

class _SkillPageState extends State<SkillPage> {
  final TextEditingController _skillController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final List<Map<String, String>> _skills = [];
  String? _selectedProficiency;
  final List<String> _proficiencyOptions = ['Beginner', 'Intermediate', 'Advanced'];

  void _addSkill() {
    final skill = _skillController.text;
    final experience = _experienceController.text;
    final proficiency = _selectedProficiency;

    if (skill.isNotEmpty && experience.isNotEmpty && proficiency != null) {
      setState(() {
        _skills.add({
          'skill': skill,
          'experience': experience,
          'proficiency': proficiency,
        });
        _skillController.clear();
        _experienceController.clear();
        _selectedProficiency = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Your Skills'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Handle settings icon press
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _skillController,
              decoration: InputDecoration(labelText: 'Skill'),
            ),
            TextField(
              controller: _experienceController,
              decoration: InputDecoration(labelText: 'Experience'),
            ),
            DropdownButton<String>(
              value: _selectedProficiency,
              hint: Text('Select Proficiency'),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedProficiency = newValue;
                });
              },
              items: _proficiencyOptions.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addSkill,
              child: Text('Add Skill'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _skills.length,
                itemBuilder: (context, index) {
                  final skill = _skills[index];
                  return ListTile(
                    title: Text(skill['skill']!),
                    subtitle: Text('Experience: ${skill['experience']} - Proficiency: ${skill['proficiency']}'),
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
