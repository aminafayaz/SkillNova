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
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                // Handle settings icon press
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              // Your existing code for the body
            ],
          ),
        ),
      ),
    );
  }
}
