import 'package:flutter/material.dart';

class Activity {
  String id;
  String title;
  String description;
  DateTime createdAt;

  Activity({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });
}
