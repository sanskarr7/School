import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NoticeScreen(),
    );
  }
}

class NoticeScreen extends StatelessWidget {
  const NoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildNoticeCard(
              'Title 1', // Add title here
              'It is a long established fact that a reader will be distracted by the readable content of',
              '20/20/2050',
            ),
            _buildNoticeCard(
              'Title 2', // Add title here
              'It is a long established fact that a reader will be distracted by the readable content of',
              '2 hours ago',
            ),
            _buildNoticeCard(
              'Title 3', // Add title here
              'It is a long established fact that a reader will be distracted by the readable content of',
              '2 hours ago',
            ),
            _buildNoticeCard(
              'Title 4', // Add title here
              'It is a long established fact that a reader will be distracted by the readable content of',
              '2 hours ago',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoticeCard(String title, String content, String time) { // Add title parameter
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.description),
        ),
        title: Column( // Use a Column to display title and content
          crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), // Display the title
            Text(content), // Display the content
          ],
        ),
        subtitle: Text(time),
      ),
    );
  }
}