import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:portal_ckc/constant/style_of_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonLogin extends StatefulWidget {
  final Function onPressed;
  final String nameButton;

  const ButtonLogin({
    super.key,
    required this.nameButton,
    required this.onPressed,
  });

  @override
  State<ButtonLogin> createState() => _ButtonLogin();
}

class _ButtonLogin extends State<ButtonLogin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF1976D2).withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: widget.onPressed(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          widget.nameButton,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
