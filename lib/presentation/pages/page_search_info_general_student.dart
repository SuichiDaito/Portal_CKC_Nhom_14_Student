import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portal_ckc/presentation/sections/search_section_in_class_roster.dart';

class PageSearchInfoGeneralStudent extends StatefulWidget {
  PageSearchInfoGeneralStudent({super.key});
  @override
  State<PageSearchInfoGeneralStudent> createState() => SearchInfo();
}

class SearchInfo extends State<PageSearchInfoGeneralStudent> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        title: Text(
          'Tra cứu học phí',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            context.pop('/home/admin');
          },
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          SearchSectionInClassRoster(controller: TextEditingController()),
        ],
      ),
    );
  }
}
