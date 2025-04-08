import 'package:flutter/material.dart';

class SiteLogo extends StatelessWidget {
  final VoidCallback onTap;

  const SiteLogo({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Row(
        children: [
          Icon(Icons.monetization_on_rounded, color: Colors.green), 
          SizedBox(width: 8),
          Text(
            'BudgetBureau',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
