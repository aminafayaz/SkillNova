import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  final int creditPoints;
  final Function(int) updateCreditPoints;

  HelpPage({required this.creditPoints, required this.updateCreditPoints});

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final List<Map<String, String>> _requests = [
    {'skill': 'Watercolour Painting', 'description': 'Need help with watercolour techniques.', 'proficiency': 'Beginner'},
    {'skill': 'Yoga', 'description': 'Looking for advanced yoga poses.', 'proficiency': 'Advanced'},
    // Add more requests here
  ];

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
        title: Text('Help Requests'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Credit Points: ${widget.creditPoints}'),
            Expanded(
              child: ListView.builder(
                itemCount: _requests.length,
                itemBuilder: (context, index) {
                  final request = _requests[index];
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
                          request['skill']!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text('Description: ${request['description']}'),
                        SizedBox(height: 5),
                        Text('Proficiency: ${request['proficiency']}'),
                        SizedBox(height: 5),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatPage(
                                  userName: request['skill']!,
                                  proficiency: request['proficiency']!,
                                  updateCreditsCallback: _updateCredits,
                                  isHelping: true, // User is helping
                                ),
                              ),
                            );
                          },
                          child: Text('Help'),
                        ),
                      ],
                    ),
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