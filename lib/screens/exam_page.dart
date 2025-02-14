import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exam Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: ExamPage(),
    );
  }
}

class ExamPage extends StatefulWidget {
  const ExamPage({super.key});

  @override
  _ExamPageState createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Timer _timer;
  int _countdown = 10800; // 3 hours in seconds
  bool _isTimeUp = false;
  PlatformFile? _pickedFile;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _startTimer();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_countdown == 0) {
          setState(() {
            _isTimeUp = true;
            timer.cancel();
          });
        } else {
          setState(() {
            _countdown--;
          });
        }
      },
    );
  }

  Future<void> _pickFile() async {
    if (_isTimeUp) return;

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _pickedFile = result.files.first;
      });
    }
  }

  void _submitFile() {
    if (_isTimeUp) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Time is up! You cannot submit the file.')),
      );
      return;
    }

    if (_pickedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a file to submit.')),
      );
      return;
    }

    // Handle file submission
    print("Submitted File: ${_pickedFile!.name}");
    // You can add your logic to upload the file
  }

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer.cancel();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Page', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: 'Exam Routing'),
            Tab(text: 'Online Exam'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Exam Routing Tab
          Center(
            child: Card(
              elevation: 5,
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  'assets/exam_routing.png', // Add your routing image in assets
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 250, // Reduced height for smaller screens
                ),
              ),
            ),
          ),
          // Online Exam Tab
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      'assets/question_image.png', // Add your question image in assets
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 250, // Reduced height for smaller screens
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Flexible Layout for button to avoid overflow
                LayoutBuilder(
                  builder: (context, constraints) {
                    double buttonWidth = constraints.maxWidth * 0.6; // Use 60% of screen width for button
                    return SizedBox(
                      width: buttonWidth, // Use the calculated width
                      child: ElevatedButton(
                        onPressed: _isTimeUp ? null : _pickFile,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Adjusted padding
                          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        child: const Text('Select PDF File'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                if (_pickedFile != null)
                  Text(
                    'Selected File: ${_pickedFile!.name}',
                    style: const TextStyle(fontSize: 14, color: Colors.green),
                  ),
                const SizedBox(height: 16),
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      'Time Remaining: ${_formatTime(_countdown)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _isTimeUp ? Colors.red : Colors.green,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                LayoutBuilder(
                  builder: (context, constraints) {
                    double buttonWidth = constraints.maxWidth * 0.6; // Use 60% of screen width for button
                    return SizedBox(
                      width: buttonWidth, // Use the calculated width
                      child: ElevatedButton(
                        onPressed: _isTimeUp ? null : _submitFile,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Adjusted padding
                          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        child: const Text('Submit File'),
                      ),
                    );
                  },
                ),
                if (_isTimeUp)
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      'Time Up! You cannot submit your file now.',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
