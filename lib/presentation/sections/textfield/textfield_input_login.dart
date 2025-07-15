import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextfieldInputLogin extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  TextInputType keyboardType = TextInputType.text;

  TextfieldInputLogin({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.keyboardType,
  });
  @override
  State<TextfieldInputLogin> createState() => TextFieldLogin();
}

class TextFieldLogin extends State<TextfieldInputLogin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          labelText: widget.label,
          prefixIcon: Icon(widget.icon, color: Color(0xFF1976D2)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(20),
          labelStyle: TextStyle(color: Colors.grey[600]),
        ),
      ),
    );
  }
}
