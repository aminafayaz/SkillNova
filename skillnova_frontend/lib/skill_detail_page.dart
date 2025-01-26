import 'package:flutter/material.dart';

class SkillDetailPage extends StatelessWidget {
  final String skillName;
  final List<Map<String, String>> users;
  final Function(String) endChatCallback;

  SkillDetailPage({required this.skillName, required this.users, required this.endChatCallback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(skillName),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text(user['name']!),
            subtitle: Text(user['proficiency']!),
            trailing: IconButton(
              icon: Icon(Icons.chat),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      userName: user['name']!,
                      proficiency: user['proficiency']!,
                      endChatCallback: endChatCallback,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  final String userName;
  final String proficiency;
  final Function(String) endChatCallback;

  ChatPage({required this.userName, required this.proficiency, required this.endChatCallback});

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
    widget.endChatCallback(widget.proficiency);
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 15),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Enter your message',
                      ),
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