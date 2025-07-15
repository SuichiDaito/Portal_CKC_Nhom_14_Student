import 'package:flutter/material.dart';

class SearchSectionInClassRoster extends StatefulWidget {
  final TextEditingController controller;
  SearchSectionInClassRoster({super.key, required this.controller});
  @override
  State<SearchSectionInClassRoster> createState() => SearchSection();
}

class SearchSection extends State<SearchSectionInClassRoster> {
  bool _isFocused = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          controller: widget.controller,
          style: TextStyle(fontSize: 16),
          decoration: InputDecoration(
            hintText: 'Nhập tên lớp để tìm kiếm',
            hintStyle: TextStyle(color: Colors.grey[600], fontSize: 16),
            prefixIcon: Icon(Icons.search_outlined, color: Colors.grey[600]),
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.transparent, width: 0),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
