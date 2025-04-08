import 'package:flutter/material.dart';

class Milestones extends StatelessWidget {
  final List<_Badge> badges = [
    _Badge(label: '1 Day No Spend', earned: true),
    _Badge(label: '5 Days No Spend', earned: true),
    _Badge(label: '10 Days Minimal Spend', earned: false),
    _Badge(label: '14 Days In-Budget', earned: false),
    _Badge(label: 'Best Saver - 1 Month', earned: false, isFinal: true),
  ];

  Milestones({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Milestones',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          itemCount: badges.length,
          itemBuilder: (context, index) {
            final badge = badges[index];
            return Column(
              children: [
                _BadgeWidget(badge: badge),
                if (index != badges.length - 1)
                  const Icon(Icons.more_vert, color: Colors.white24),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Badge {
  final String label;
  final bool earned;
  final bool isFinal;

  _Badge({required this.label, required this.earned, this.isFinal = false});
}

class _BadgeWidget extends StatelessWidget {
  final _Badge badge;

  const _BadgeWidget({required this.badge});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: badge.earned ? Colors.amber : Colors.grey[800],
            border: Border.all(color: Colors.white12),
          ),
          child: Icon(
            badge.isFinal ? Icons.attach_money : Icons.shield,
            color: badge.earned ? Colors.black : Colors.white30,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          badge.label,
          style: TextStyle(
            fontSize: 12,
            color: badge.earned ? Colors.white : Colors.white38,
          ),
        ),
        if (badge.isFinal && badge.earned)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ElevatedButton.icon(
              onPressed: () {
                // Logic to share badge to Instagram
              },
              icon: const Icon(Icons.share, color: Colors.white),
              label: const Text('Share to Instagram'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2DA7B3),
                foregroundColor: Colors.white,
              ),
            ),
          ),
      ],
    );
  }
}
