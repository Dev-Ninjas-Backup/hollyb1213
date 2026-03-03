import 'package:flutter/material.dart';

class Schedule {
  final String title;
  final String subtitle;
  final String time;
  final String amount;
  final String statusText;

  Schedule({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.amount,
    required this.statusText,
  });

  Color get statusBackgroundColor {
    switch (statusText.toLowerCase()) {
      case 'now':
        return const Color(0xFFDFF7DF);
      case 'pending':
        return Colors.yellow.shade100;
      case 'upcoming':
        return Colors.blue.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  Color get statusColor {
    switch (statusText.toLowerCase()) {
      case 'now':
        return Colors.green;
      case 'pending':
        return Colors.yellow[800]!;
      case 'upcoming':
        return Colors.blue[800]!;
      default:
        return Colors.grey[800]!;
    }
  }
}
