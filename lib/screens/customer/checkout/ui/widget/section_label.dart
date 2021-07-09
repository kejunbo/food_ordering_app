import 'package:flutter/material.dart';

class SectionLabel extends StatelessWidget {
  final String sectionTitle;
  final Color color;

  SectionLabel({this.sectionTitle, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Expanded(
            child: Divider(color: color ?? Colors.white, thickness: 2),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              sectionTitle ?? "-",
              style: TextStyle(
                fontFamily: "DancingScript",
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color ?? Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Divider(color: color ?? Colors.white, thickness: 2),
          ),
        ],
      ),
    );
  }
}
