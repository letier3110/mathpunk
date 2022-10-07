import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';

class Status {
  late String name;
  late String description;
  double stack = 0;
  String asset;

  Status({
    this.asset = 'assets/relics/chess_pyramid.png',
    statusName = '',
    statusStack = 0,
    statusDescription = '',
  }) {
    name = statusName;
    stack = statusStack;
    description = description;
  }

  StatelessWidget getStatusName() {
    return Text(
      name,
      style: const TextStyle(color: Colors.white, fontSize: 16),
    );
  }

  void addStack(int stack) {
    this.stack += stack;
  }

  StatelessWidget getStatusDescription() {
    return HighlightDescriptionText(text: description);
  }

  factory Status.fromJson(dynamic json) {
    return Status(
      statusName: json['name'] as String,
      statusStack: json['stack'] as int,
      statusDescription: json['description'] as String,
    );
  }

  Map toJson() => {
        'name': name,
        'stack': stack,
        'description': description,
        'asset': asset,
      };
}
