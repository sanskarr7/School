import 'package:flutter/material.dart';
import '../widgets/assignment_card.dart';
import '../widgets/filter_chips.dart';
import 'assignment_details_screen.dart';

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({super.key});

  @override
  _AssignmentScreenState createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  String selectedFilter = 'All Subjects';

  final List<Map<String, dynamic>> assignments = [
    {
      'subject': 'Math',
      'title': 'Assignment 1',
      'dueDate': '20-12-2024',
      'dueTime': '2 January 2025, 10:15 PM',
      'icon': Icons.calculate,
      'isSubmitted': false
    },
    {
      'subject': 'Account',
      'title': 'Final Account',
      'dueDate': '21-12-2024',
      'dueTime': '1 January 2025, 10:15 PM',
      'icon': Icons.book,
      'isSubmitted': false
    },
    {
      'subject': 'Science',
      'title': 'Pressure',
      'dueDate': '22-12-2024',
      'dueTime': '2 January 2025, 10:15 PM',
      'icon': Icons.science,
      'isSubmitted': true
    },
    {
      'subject': 'Computer Science',
      'title': 'Operating System',
      'dueDate': '23-12-2024',
      'dueTime': '2 January 2025, 10:15 PM',
      'icon': Icons.computer,
      'isSubmitted': true
    },
    {
      'subject': 'Math',
      'title': 'Assignment 2',
      'dueDate': '24-12-2024',
      'dueTime': '9 January 2025, 10:15 PM',
      'icon': Icons.calculate,
      'isSubmitted': false
    },
  ];

  List<Map<String, dynamic>> get filteredAssignments {
    if (selectedFilter == 'All Subjects') {
      return assignments;
    }
    return assignments
        .where((assignment) => assignment['subject'] == selectedFilter)
        .toList();
  }

  List<Map<String, dynamic>> get filteredAssignmentsByStatus {
    return filteredAssignments
        .where((assignment) => assignment['isSubmitted'] == true)
        .toList();
  }

  void submitAssignment(int index) {
    setState(() {
      assignments[index]['isSubmitted'] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Assignments',
            style: TextStyle(color: Color.fromARGB(255, 2, 2, 2),
            fontWeight: FontWeight.bold,),
            
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          bottom: const TabBar(
            indicatorColor: Color(0xFF60B8AF),
  labelColor: Color(0xFF60B8AF),
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Assigned'),
              Tab(text: 'Submitted'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildAssignmentList(filteredAssignments, false),
            _buildAssignmentList(filteredAssignmentsByStatus, true),
          ],
        ),
      ),
    );
  }

  Widget _buildAssignmentList(List<Map<String, dynamic>> assignments, bool isSubmitted) {
    return Column(
      children: [
        FilterChips(
          onFilterSelected: (filter) {
            setState(() {
              selectedFilter = filter;
            });
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: assignments.length,
            itemBuilder: (context, index) {
              final assignment = assignments[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AssignmentDetailsScreen(
                          assignment: assignment,
                        ),
                      ),
                    );
                  },
                  child: AssignmentCard(
                    subject: assignment['subject']!,
                    title: assignment['title']!,
                    dueDate: assignment['dueDate']!,
                    dueTime: assignment['dueTime']!,
                    icon: assignment['icon']!,
                    titleAlignment: TextAlign.center,
                    trailing: isSubmitted
                        ? const Icon(Icons.check_circle, color:  Color(0xFF60B8AF))
                        : IconButton(
                            icon: Icon(
                              Icons.check_circle,
                              color: assignment['isSubmitted']
                                  ? const Color(0xFF60B8AF)
                                  : Colors.grey,
                            ),
                            onPressed: () => submitAssignment(index),
                          ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}