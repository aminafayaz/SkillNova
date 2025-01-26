import 'package:flutter/material.dart';

class SkillPage extends StatefulWidget {
  final int creditPoints;
  final Function(int) updateCreditPoints;

  SkillPage({required this.creditPoints, required this.updateCreditPoints});

  @override
  _SkillPageState createState() => _SkillPageState();
}

class _SkillPageState extends State<SkillPage> {
  final List<Map<String, String>> _skills = [
    {'skill': 'Watercolour Painting', 'description': 'Learn the art of watercolour painting.', 'proficiency': 'Intermediate'},
    {'skill': 'Yoga', 'description': 'Practice yoga for a healthy mind and body.', 'proficiency': 'Advanced'},
    // Add more skills here
  ];

  final TextEditingController _skillController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedProficiency;

  void _addSkill() {
    if (_skillController.text.isNotEmpty && _descriptionController.text.isNotEmpty && _selectedProficiency != null) {
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
        title: Text('Skills'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Credit Points: ${widget.creditPoints}'),
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
                        SizedBox(height: 5),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatPage(
                                  userName: skill['skill']!,
                                  proficiency: skill['proficiency']!,
                                  updateCreditsCallback: _updateCredits,
                                  isHelping: false, // User is seeking help
                                ),
                              ),
                            );
                          },
                          child: Text('Chat'),
                        ),
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

class ChatPage extends StatefulWidget {
  final String userName;
  final String proficiency;
  final Function(String, bool) updateCreditsCallback;
  final bool isHelping;

  ChatPage({required this.userName, required this.proficiency, required this.updateCreditsCallback, required this.isHelping});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<String> messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add(_controller.text);
        _controller.clear();
      });
    }
  }

  void _endChat() {
    widget.updateCreditsCallback(widget.proficiency, widget.isHelping);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.userName}'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: _endChat,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: index % 2 == 0 ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: index % 2 == 0 ? Colors.grey[300] : Colors.blue[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(messages[index]),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter your message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
          SizedBox(height: 10), // Add padding at the bottom
        ],
      ),
    );
  }
}
