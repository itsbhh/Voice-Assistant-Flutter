import 'package:flutter/material.dart';
import 'package:voice_assistant/pallete.dart';

class FeatureBox extends StatelessWidget {
  final Color color;
  final String headerText;
  const FeatureBox({
    super.key,
    required this.color,
    required this.headerText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          Text(
            headerText,
            style: const TextStyle(
              fontFamily: 'Cera Pro',
              color: Pallete.blackColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
