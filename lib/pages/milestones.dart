import 'package:flutter/material.dart';

class Milestones extends StatelessWidget {
  final List<_Badge> badges = [
    _Badge(
      label: '1 Day No Spend',
      earned: true,
      description: 'One full day without spending any money.',
    ),
    _Badge(
      label: '5 Days No Spend',
      earned: true,
      description: 'Five days straight without spending.',
    ),
    _Badge(
      label: '10 Days Minimal Spend',
      earned: false,
      description: 'Spend only on essentials for 10 days to earn this badge.',
    ),
    _Badge(
      label: 'Two weeks in-Budget',
      earned: false,
      description: 'Stay within your set budget for two full weeks.',
    ),
    _Badge(
      label: 'Best Saver - 1 Month',
      earned: false,
      isFinal: true,
      description: 'Your best month of saving. Complete 30 days of minimal spending.',
    ),
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
  final String description;

  _Badge({
    required this.label,
    required this.earned,
    this.isFinal = false,
    required this.description,
  });
}

class _BadgeWidget extends StatelessWidget {
  final _Badge badge;

  const _BadgeWidget({required this.badge});

  void _showBadgeDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          badge.label,
          style: const TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              badge.description,
              style: TextStyle(
                color: badge.earned ? Colors.white70 : Colors.white38,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              badge.earned
                  ? 'You have earned this badge.'
                  : 'You haven’t earned this badge yet.',
              style: TextStyle(
                color: badge.earned ? Colors.greenAccent : Colors.orangeAccent,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: Colors.tealAccent)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showBadgeDetails(context),
      child: Column(
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
          if (badge.earned)
            const Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                'Earned! 🎉',
                style: TextStyle(color: Colors.greenAccent, fontSize: 11),
              ),
            )
          else
            const Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                'Keep going...',
                style: TextStyle(color: Colors.white30, fontSize: 11),
              ),
            ),
          if (badge.isFinal && badge.earned)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.share, color: Colors.white),
                label: const Text('Share to Instagram'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2DA7B3),
                  foregroundColor: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
