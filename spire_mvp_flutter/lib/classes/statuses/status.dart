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
    statusStack = 0.0,
    statusDescription = '',
  }) {
    name = statusName;
    description = statusDescription;
    stack = statusStack;
    description = description;
  }

  StatelessWidget getStatusName(BuildContext context) {
    return Text(
      name,
      style: const TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  void addStack(double stack) {
    this.stack += stack;
  }

  bool isStatusPositive() => true;

  bool isShowStatus() => stack > 0;

  bool isShowStack() => true;

  void setStack(double stack) {
    this.stack = stack;
  }

  StatelessWidget getStatusDescription(BuildContext context) {
    return HighlightDescriptionText(
      text: description,
      fontSize: 14,
    );
  }

  factory Status.fromJson(dynamic json) {
    return Status(
      statusName: json['name'] as String,
      statusStack: double.parse(json['stack']),
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
