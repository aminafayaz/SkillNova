import 'package:flutter/material.dart'; 

class MySquare  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              height: 400,
              color: Colors.deepPurple[200],
            ),
          );
  }
}