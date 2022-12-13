import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {

  final String text;
  final String username;
  final String imageUrl;
  final bool isMe;
  final Key key;

  MessageBubble(this.text, this.username, this.imageUrl, this.isMe, {this.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        Container(
          decoration: BoxDecoration(
            color: !isMe
                ? Theme.of(context).colorScheme.primaryContainer
                : Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
              bottomRight: isMe ? Radius.circular(0) : Radius.circular(12)
            ),
          ),
          width: 140,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          child: Column(
            children: <Widget> [
              Text(
                username,
                style: TextStyle(
                    color: !isMe
                        ? Theme.of(context).colorScheme.onPrimaryContainer
                        : Theme.of(context).colorScheme.onSecondaryContainer,
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.start,
              ),
              Text(
                text,
                style: TextStyle(
                    color: !isMe
                        ? Theme.of(context).colorScheme.onPrimaryContainer
                        : Theme.of(context).colorScheme.onSecondaryContainer
                ),
                textAlign: TextAlign.start,
              ),
            ]
          ),
        )
      ]
    );
  }
}
