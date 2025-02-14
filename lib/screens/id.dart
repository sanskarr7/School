import 'package:flutter/material.dart';

class StudentIdCard extends StatelessWidget {
  const StudentIdCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ID Card', // App bar title
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0), // White text color
            fontSize: 25, // Increased font size
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, // Center the title
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Back button
          onPressed: () {
            Navigator.pop(context); // Navigate to the previous page
          },
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Match app bar color with #60B8AF
      ),
      body: Center(
        child: Container(
          width: 350, // Increased width for a bigger card
          height: 500, // Increased height for a bigger card
          decoration: BoxDecoration(
            color: const Color(0xFF60B8AF), // Solid teal color for the container
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // College Name Above Profile Avatar
              const Padding(
                padding: EdgeInsets.only(bottom: 20), // Space between college name and avatar
                child: Text(
                  'ABC University', // College name
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24, // Larger font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Profile Picture (with circle border)
              Container(
                width: 140, // Increased size of the avatar
                height: 140, // Increased size of the avatar
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4), // Keep the white border
                ),
                child: const Center(
                  child: Icon(
                    Icons.person,
                    size: 100, // Increased icon size
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Name
              const Text(
                'ROSIE JENKINS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Test your major/class here',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 20),
              // Details
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    _buildDetailRow('ID No', '012345789'),
                    _buildDetailRow('Course', 'MDS 2428'),
                    _buildDetailRow('Phone', '+0 123.456.789'),
                    _buildDetailRow('Email', 'textyouremail@email.com'),
                  ],
                ),
              ),
              // Student ID
              const SizedBox(height: 20),
              Container(
                width: 200, // Increased width for better visibility
                height: 40, // Increased height for better visibility
                decoration: const BoxDecoration(
                  color: Colors.transparent, // No background color
                ),
                child: const Center(
                  child: Text(
                    'Student ID: 012345789', // Student ID
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14, // Increased font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 10,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
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