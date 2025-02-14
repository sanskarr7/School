import 'package:edu360/screens/exam_page.dart';
import 'package:edu360/screens/fees_screen.dart';
import 'package:edu360/screens/student_profile.dart';
import 'package:edu360/widgets/about_us_section.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import FontAwesome
import 'package:edu360/screens/leave_note_screen.dart';
import 'package:edu360/screens/login_screen.dart';
import 'assignment_screen.dart';
import 'library_screen.dart';
import 'results_screen.dart';
// import 'change_profile_screen.dart';
import 'notice_screen.dart';
import 'attendance_screen.dart';
import '../widgets/grid_item.dart';
import 'subjects_screen.dart';
import 'timetable_screen.dart';
import 'calender_screen.dart'; // Import CalendarScreen

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HomePageContent(),
    const NoticeScreen(),
    const CalendarScreen(),  // Updated to use the CalendarScreen
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipOval(
              child: Image.asset(
                'san.jpg',
                height: 30,
                width: 30,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'Edu360',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 5, 5, 5),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.notifications, color: Colors.black),
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notice',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: const Color(0xFF47C9E0),
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final email = user?.email ?? 'No email found';

    return Column(
      children: [
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DetailScreen()),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xFF73bdb6),
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x33171515),
                  blurRadius: 6,
                  spreadRadius: 4,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sanskar Satyal',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      email, // Display the dynamic email here
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Reliance College',
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      '9748274572',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: GridView.count(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              GridItem(
                icon: FontAwesomeIcons.userCheck,
                label: 'Attendance',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AttendanceScreen(),
                    ),
                  );
                },
              ),
              GridItem(
                icon: FontAwesomeIcons.table,
                label: 'Time Table',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TimetableScreen(),
                    ),
                  );
                },
              ),
              GridItem(
                icon: FontAwesomeIcons.bookOpen,
                label: 'Library',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LibraryScreen(),
                    ),
                  );
                },
              ),
              GridItem(
                icon: FontAwesomeIcons.wallet,
                label: 'Fee',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FeesScreen(),
                    ),
                  );
                },
              ),
              const GridItem(
                icon: FontAwesomeIcons.bus,
                label: 'Bus',
              ),
              GridItem(
                icon: FontAwesomeIcons.tasks,
                label: 'Assignment',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AssignmentScreen(),
                    ),
                  );
                },
              ),
              GridItem(
                icon: FontAwesomeIcons.graduationCap,
                label: 'Subjects',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SubjectsScreen(),
                    ),
                  );
                },
              ),
              GridItem(
                icon: FontAwesomeIcons.university,
                label: 'Exam',
                 onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExamPage(),
                    ),
                  );
                },
              ),
              GridItem(
                icon: FontAwesomeIcons.chartLine,
                label: 'Result',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ResultsScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          ListTile(
            title: const Text('Leave'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LeaveNoteScreen()),
              );
            },
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('Online Meeting'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(height: 1),
         ListTile(
  title: const Text('About Us'),
  trailing: const Icon(Icons.chevron_right),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AboutUsSection()),
    );
  },
),

          const Divider(height: 1),
          ListTile(
            title: const Text('Logout'),
            trailing: const Icon(Icons.exit_to_app),
            onTap: () async {
              await Supabase.instance.client.auth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}