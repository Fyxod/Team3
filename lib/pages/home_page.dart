import 'package:bbapp/pages/contact_us.dart';
import 'package:bbapp/pages/milestones.dart';
import 'package:bbapp/widgets/site_logo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:bbapp/pages/notifications_page.dart';
import 'package:bbapp/pages/login_page.dart';
import 'package:bbapp/pages/profile_page.dart';
import 'package:bbapp/services/auth_service.dart'; 

class Badge {
  final String label;
  final bool earned;
  final bool isFinal;
  final String description;

  Badge({
    required this.label,
    required this.earned,
    this.isFinal = false,
    required this.description,
  });
}

class HomePage extends StatefulWidget {
  final String username;

  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Badge> allBadges = [
    Badge(label: '1 Day No Spend', earned: true, description: 'You went one full day without spending.'),
    Badge(label: '5 Days No Spend', earned: true, description: 'Five days straight without spending.'),
    Badge(label: '10 Days Minimal Spend', earned: false, description: 'Only essential spending for 10 days.'),
    Badge(label: '14 Days In-Budget', earned: false, description: 'Stayed within your budget for 2 weeks.'),
    Badge(label: 'Best Saver - 1 Month', earned: false, isFinal: true, description: 'The ultimate savings streak!'),
  ];

  List<Badge> get earnedBadges => allBadges.where((badge) => badge.earned).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF121212),
      endDrawer: Drawer(
        backgroundColor: const Color(0xFF1E1E1E),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF2C2C2C)),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            _buildDrawerTile(Icons.home, 'Home', () {
              Navigator.pop(context);
            }),
            _buildDrawerTile(Icons.person, 'Profile', () {
              Navigator.pop(context);
              _showPinDialog();
            }),
            _buildDrawerTile(Icons.flag, 'Milestones', () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => Milestones()));
            }),
            _buildDrawerTile(Icons.contact_mail, 'Contact Us', () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactUs()));
            }),
            const Divider(color: Colors.grey),
            _buildDrawerTile(Icons.logout, 'Logout', () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: const Color(0xFF1E1E1E),
                    title: const Text('Confirm Logout', style: TextStyle(color: Colors.white)),
                    content: const Text('Are you sure you want to logout?', style: TextStyle(color: Colors.white70)),
                    actions: [
                      TextButton(
                        style: TextButton.styleFrom(foregroundColor: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                            (route) => false,
                          );
                        },
                        child: const Text('Logout'),
                      ),
                    ],
                  );
                },
              );
            }),
          ],
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                children: [
                  SiteLogo(onTap: () {}),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.notifications, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NotificationsPage()),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () {
                      _scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: 150,
              width: double.infinity,
              color: const Color(0xFF2C2C2C),
              child: Center(
                child: Text(
                  "Welcome, ${widget.username}!",
                  style: GoogleFonts.oswald(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
              child: TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay ?? DateTime.now(), day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                calendarFormat: CalendarFormat.month,
                availableCalendarFormats: const {
                  CalendarFormat.month: 'Month',
                },
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.greenAccent,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  weekendTextStyle: TextStyle(color: Colors.redAccent),
                  outsideTextStyle: TextStyle(color: Colors.grey),
                  defaultTextStyle: TextStyle(color: Colors.white),
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: Colors.white70),
                  weekendStyle: TextStyle(color: Colors.redAccent),
                ),
                headerStyle: const HeaderStyle(
                  titleTextStyle: TextStyle(color: Colors.white, fontSize: 16),
                  formatButtonTextStyle: TextStyle(color: Colors.white),
                  formatButtonDecoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
                  rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
                ),
              ),
            ),
            Container(
  padding: const EdgeInsets.all(16),
  color: const Color(0xFF1E1E1E),
  width: double.infinity,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const Text(
        'Your Earned Badges',
        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 12),
      ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Milestones()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.greenAccent,
          foregroundColor: Colors.black,
        ),
        child: const Text('Tap to see your badges'),
      ),
    ],
  ),
),

          ],
        ),
      ),
    );
  }

  Widget _buildBadgeIcon(Badge badge) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.amber,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white24),
            ),
            child: Icon(
              badge.isFinal ? Icons.attach_money : Icons.shield,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            badge.label,
            style: const TextStyle(color: Colors.white70, fontSize: 10),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showPinDialog() {
    final TextEditingController pinController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: const Text('Enter PIN', style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: pinController,
            keyboardType: TextInputType.number,
            obscureText: true,
            maxLength: 4,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Enter 4-digit PIN',
              hintStyle: TextStyle(color: Colors.grey),
              counterText: '',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.greenAccent),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel', style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () async {
                final pin = pinController.text.trim();
                final result = await AuthService.verifyPin(widget.username, pin);

                if (result) {
                  Navigator.of(context).pop();
                  Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => ProfilePage(username: widget.username)),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Incorrect PIN'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                foregroundColor: Colors.black,
              ),
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDrawerTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}
