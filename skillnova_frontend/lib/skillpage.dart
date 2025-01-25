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
      });

      _skillController.clear();
      _experienceController.clear();
      _selectedProficiency = null;
    }
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
              DropdownButtonFormField<String>(
                value: _selectedProficiency,
                decoration: InputDecoration(
                  labelText: 'Proficiency',
                  border: OutlineInputBorder(),
                ),
                items: _proficiencyOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedProficiency = newValue;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _addSkill();
                  Navigator.of(context).pop();
                },
                child: Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                title: Text(_skills[index]['skill']!),
                subtitle: Text(
                    'Experience: ${_skills[index]['experience']} years, Proficiency: ${_skills[index]['proficiency']}'),
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
    );
  }
}
