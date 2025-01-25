import 'package:flutter/material.dart';

class SkillDetailPage extends StatelessWidget {
  final String skillName;
  final List<Map<String, String>> users;

  SkillDetailPage({required this.skillName, required this.users});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(skillName),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users[index]['name']!),
            subtitle: Text('Proficiency: ${users[index]['proficiency']}'),
          );
        },
      ),
    );
  }
}