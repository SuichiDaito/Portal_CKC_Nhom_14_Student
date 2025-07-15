import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EmptySection extends StatelessWidget {
  final String message;
  const EmptySection({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: TextStyle(
          fontSize: 18,
          color: Colors.grey,
          fontWeight: FontWeight.w300,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}
