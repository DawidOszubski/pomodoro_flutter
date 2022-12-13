import 'package:flutter/material.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.greenAccent.withOpacity(0.6),
          boxShadow: [BoxShadow(color: Colors.green)]),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              Icons.check_circle_outline,
              color: Color.fromRGBO(25, 124, 25, 1.0),
              size: 40,
            ),
          ),
          Flexible(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
              child: Text(
                text,
                style: TextStyle(color: Color.fromRGBO(7, 79, 7, 1.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
