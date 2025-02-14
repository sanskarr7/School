import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class AssignmentDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> assignment;

  const AssignmentDetailsScreen({super.key, required this.assignment});

  @override
  // ignore: library_private_types_in_public_api
  _AssignmentDetailsScreenState createState() =>
      _AssignmentDetailsScreenState();
}

class _AssignmentDetailsScreenState extends State<AssignmentDetailsScreen> {
  String? _fileName;
  bool _fileAttached = false;

  // Function to pick a PDF file
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
        _fileAttached = true;
      });
    }
  }

  // Function to submit the assignment
  void _submitAssignment() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Assignment Submitted Successfully!'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context);
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildUploadSection() {
    return GestureDetector(
      onTap: _pickFile,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.file_upload, color: Color(0xFF60B8AF)),
            const SizedBox(width: 10),
            Text(
              _fileAttached ? _fileName! : 'Tap to select a PDF file',
              style: const TextStyle(fontSize: 16, color: Colors.black54),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

 Widget _buildSubmitButton() {
  return ElevatedButton(
    onPressed: _fileAttached ? _submitAssignment : null,
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF60B8AF), // Enabled background color
      disabledBackgroundColor: const Color(0xFF60B8AF), // Disabled background color
      foregroundColor: Colors.white, // Enabled text (and icon) color
      disabledForegroundColor: Colors.white, // Disabled text (and icon) color
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: const TextStyle(fontSize: 18),
    ),
    child: Text(
      widget.assignment['isSubmitted']
          ? 'Already Submitted'
          : 'Submit Assignment',
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6), // Light background for contrast
      appBar: AppBar(
        title: const Text(
          'Assignment Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 0, 0), // Updated to requested color
          ),
        ),
        backgroundColor: Colors.white, // Updated to white
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Assignment Card
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.assignment['title'],
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF60B8AF), // Updated title color
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Subject: ${widget.assignment['subject']}',
                        style: const TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      const SizedBox(height: 8),
                      _buildInfoRow(Icons.calendar_today,
                          'Due: ${widget.assignment['dueDate']}'),
                      const SizedBox(height: 8),
                      _buildInfoRow(Icons.access_time,
                          'Time: ${widget.assignment['dueTime']}'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Description
              const Text(
                'Assignment Instructions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Text(
                  'Please read the instructions carefully and submit your assignment in PDF format before the deadline.',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
              const SizedBox(height: 20),

              // Upload Section
              const Text(
                'Upload Your Homework (PDF)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildUploadSection(),
              const SizedBox(height: 20),

              // Submit Button
              Center(child: _buildSubmitButton()),
            ],
          ),
        ),
      ),
    );
  }
}