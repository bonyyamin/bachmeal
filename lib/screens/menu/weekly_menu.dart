import 'package:flutter/material.dart';
import 'package:bachmeal/core/theme.dart';

class WeeklyMenu extends StatelessWidget {
  final List<Map<String, String>> weeklyMenu = [
    {"day": "Friday", "morning": "White rice, bharta, dal, vegetables", "noon": "Chicken biryani", "night": "White rice, dal, fried egg, vegetables"},
    {"day": "Saturday", "morning": "Bread/parota, vegetables, boot dal", "noon": "White rice, dal, fried egg, vegetables", "night": "White rice, dal, small fish, vegetables"},
    {"day": "Sunday", "morning": "Khichuri, egg, bharta", "noon": "White rice, dal, chicken, vegetables", "night": "White rice, dal, fried egg, vegetables"},
    {"day": "Monday", "morning": "Bread/parota, vegetables, boot dal", "noon": "White rice, dal, big fish, bharta", "night": "White rice, dal, fried egg, vegetables"},
    {"day": "Tuesday", "morning": "Khichuri, egg, bharta", "noon": "White rice, dal, chicken, vegetables", "night": "White rice, dal, small fish, bharta"},
    {"day": "Wednesday", "morning": "Bread/parota, vegetables, boot dal", "noon": "White rice, dal, big fish, bharta", "night": "White rice, small fish, pulses, vegetables"},
    {"day": "Thursday", "morning": "Khichuri, vegetables, stuffed parota", "noon": "White rice, pulses, chicken", "night": "White rice, pulses, small fish, vegetables"},
  ];

  WeeklyMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Weekly Menu",
            style: AppTheme.textTheme.displaySmall,
          ),
          const SizedBox(height: 12),
          Table(
            border: TableBorder.all(color: Colors.grey.shade300, width: 1),
            columnWidths: const {
              0: FlexColumnWidth(1.5),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(3),
              3: FlexColumnWidth(3),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: AppTheme.gold.withOpacity(0.3),
                ),
                children: [
                  _buildTableHeaderCell("Day"),
                  _buildTableHeaderCell("Morning"),
                  _buildTableHeaderCell("Noon"),
                  _buildTableHeaderCell("Night"),
                ],
              ),
              ...weeklyMenu.map((meal) {
                return TableRow(
                  children: [
                    _buildTableCell(meal["day"]!),
                    _buildTableCell(meal["morning"]!),
                    _buildTableCell(meal["noon"]!),
                    _buildTableCell(meal["night"]!),
                  ],
                );
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: AppTheme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildTableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: AppTheme.textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
    );
  }
}
