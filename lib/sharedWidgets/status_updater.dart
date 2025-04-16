import 'package:flutter/material.dart';
import 'package:scrap_it/constants/colors.dart';
import 'package:scrap_it/constants/fonts.dart';

class StatusUpdater extends StatelessWidget {
  final String currentStatus;
  final List<String> statuses;
  final Function(String) onStatusChanged;

  const StatusUpdater({
    super.key,
    required this.currentStatus,
    required this.statuses,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: currentStatus,
      isExpanded: true,
      items: statuses.asMap().entries.map((entry) {
        int index = entry.key;
        String status = entry.value;
        return DropdownMenuItem<String>(
          value: index.toString(),
          child: Text(status, style: kSubtitleStyle),
        );
      }).toList(),
      onChanged: (newValue) {
        if (newValue != null) {
          onStatusChanged(newValue);
        }
      },
      underline: Container(height: 2, color: kPrimaryColor),
    );
  }
}