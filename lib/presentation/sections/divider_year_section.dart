import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthYearDivider extends StatelessWidget {
  final DateTime? date;
  final String? locale;

  const MonthYearDivider({Key? key, this.date, this.locale = 'vi_VN'})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentDate = date ?? DateTime.now();
    final formatter = DateFormat('MMMM yyyy', locale);
    final monthYear = formatter.format(currentDate);

    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            monthYear,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey, thickness: 1)),
      ],
    );
  }
}
