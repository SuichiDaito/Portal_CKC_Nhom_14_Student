import 'package:flutter/material.dart';

class TextfieldPasswordLogin extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool isVisible;
  final VoidCallback onToggleVisibility;
  TextfieldPasswordLogin({
    super.key,
    required this.controller,
    required this.label,
    required this.isVisible,
    required this.onToggleVisibility,
  });
  @override
  State<TextfieldPasswordLogin> createState() => PasswordLogin();
}

class PasswordLogin extends State<TextfieldPasswordLogin> {
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
        obscureText: !widget.isVisible,
        decoration: InputDecoration(
          labelText: widget.label,
          prefixIcon: Icon(Icons.lock, color: Color(0xFF1976D2)),
          suffixIcon: IconButton(
            icon: Icon(
              widget.isVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey[600],
            ),
            onPressed: widget.onToggleVisibility,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(20),
          labelStyle: TextStyle(color: Colors.grey[600]),
        ),
      ),
    );
  }
}
