import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Timetable',
      theme: ThemeData(
        fontFamily: 'Arial',
      ),
      home: const TimetableScreen(),
    );
  }
}

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  int _selectedDayIndex = 0; // Sunday is initially selected (index 0)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Timetable',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 25),
        ),
        actions: const [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Today", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            DateCarousel(
              selectedDayIndex: _selectedDayIndex,
              onDaySelected: (index) {
                setState(() {
                  _selectedDayIndex = index;
                });
              },
            ),
            const SizedBox(height: 30),
            Expanded(
              child: TaskList(dayIndex: _selectedDayIndex),
            ),
          ],
        ),
      ),
    );
  }
}

class DateCarousel extends StatefulWidget {
  final int selectedDayIndex;
  final Function(int) onDaySelected;

  const DateCarousel({super.key, required this.selectedDayIndex, required this.onDaySelected});

  @override
  State<DateCarousel> createState() => _DateCarouselState();
}

class _DateCarouselState extends State<DateCarousel> {
  late DateTime _currentDate;

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          final date = _currentDate.add(Duration(days: index));
          final formattedDate = DateFormat('dd').format(date);
          final dayName = DateFormat('E').format(date);

          return DateItem(
            day: dayName,
            date: formattedDate,
            isSelected: index == widget.selectedDayIndex,
            onTap: () => widget.onDaySelected(index),
          );
        },
      ),
    );
  }
}

class DateItem extends StatelessWidget {
  final String day;
  final String date;
  final bool isSelected;
  final VoidCallback onTap;

  const DateItem({
    super.key,
    required this.day,
    required this.date,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isSaturday = day == 'Sat';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Text(
              day,
              style: TextStyle(
                color: isSelected ? Colors.black : (isSaturday ? Colors.red : Colors.grey),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
               color: isSelected
                    ? (isSaturday ? Colors.red : const Color(0xFF60B8AF)) 
                    : Colors.white,
                border: Border.all(
                  color: isSaturday ? Colors.red : Colors.grey,
                ),
              ),
              child: Center(
                child: Text(
                  date,
                  style: TextStyle(color: isSelected ? Colors.white : Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  final int dayIndex;

   TaskList({super.key, required this.dayIndex});

  final Map<String, List<Task>> timetableData = {
    'Sun': [
      Task('9:00 - 10:00', 'Nepali', 'Anita Sharma'),
      Task('10:00 - 11:00', 'English', 'Bikash Khanal'),
    ],
    'Mon': [
      Task('6:30 - 7:30', 'Cloud Computing', 'Sahodar Dhungana'),
      Task('7:30 - 8:30', 'Cyber Law', 'Prakash Khanal'),
    ],
    'Tue': [],
    'Wed': [
      Task('9:00 - 10:00', 'Data Structures', 'Anil Sharma'),
    ],
    'Thu': [],
    'Fri': [],
    'Sat': [],
  };

  @override
  Widget build(BuildContext context) {
    final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final selectedDay = days[dayIndex];
    final tasks = timetableData[selectedDay] ?? [];

    if (tasks.isEmpty) {
      return const Center(child: Text("No classes scheduled for this day."));
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskCard(
          time: task.time,
          title: task.title,
          chapter: '',
          teacher: task.teacher,
        );
      },
    );
  }
}

class Task {
  final String time;
  final String title;
  final String teacher;

  Task(this.time, this.title, this.teacher);
}

class TaskCard extends StatelessWidget {
  final String time;
  final String title;
  final String chapter;
  final String teacher;

  const TaskCard({
    super.key,
    required this.time,
    required this.title,
    required this.chapter,
    required this.teacher,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(time, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            if (chapter.isNotEmpty)
              Text(chapter, style: const TextStyle(color: Colors.grey)),
            if (chapter.isNotEmpty)
              const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.person, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(teacher, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}