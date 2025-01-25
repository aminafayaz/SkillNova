import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String userName;
  final int userCredits;
  final int skillProviderCredits;

  const ChatPage({
    Key? key,
    required this.userName,
    required this.userCredits,
    required this.skillProviderCredits,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _messageController = TextEditingController();
  late int _userCredits;
  late int _skillProviderCredits;

  @override
  void initState() {
    super.initState();
    _userCredits = widget.userCredits;
    _skillProviderCredits = widget.skillProviderCredits;
  }

  void _sendMessage() {
    final message = _messageController.text;
    if (message.isNotEmpty) {
      setState(() {
        _messages.add({'sender': 'You', 'message': message});
        _messages.add({'sender': widget.userName, 'message': 'Reply from ${widget.userName}'});
        _messageController.clear();
      });
    }
  }

  void _endChat() {
    setState(() {
      _userCredits -= 10; // Deduct credits from the user
      _skillProviderCredits += 10; // Add credits to the skill provider
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Chat Ended'),
          content: Text('Your current credits: $_userCredits'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('OK'),
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
        title: Text('Chat with ${widget.userName}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Text(message['sender']!),
                  subtitle: Text(message['message']!),
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
                    controller: _messageController,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: _endChat,
              child: Text('End Chat'),
            ),
          ),
        ],
      ),
    );
  }
}
