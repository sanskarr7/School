import 'package:edu360/screens/id.dart';
import 'package:flutter/material.dart';
import 'change_profile_screen.dart'; // Import the ChangeProfileScreen

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top Profile Section
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF60B8AF), // Purple Shade
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Text(
                      "Details",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 40), // Placeholder for spacing
                  ],
                ),
                const SizedBox(height: 16),
                // Profile Picture
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 50, color: Colors.black),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Jenny Wilson",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Sr. UI/UX Designer",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Adjusted for better spacing
                  children: [
                    _iconButton(Icons.email, "Email", () => _showDialog(context, "Email", "michael.mitc@example.com")),
                    _iconButton(Icons.phone, "Call", () => _showDialog(context, "Phone", "(209) 555-0104")),
                    _iconButton(Icons.edit, "Update Profile", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ChangeProfileScreen()),
                      );
                    }),
                    _iconButton(Icons.card_membership, "Id Card", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const StudentIdCard()),
                      );
                    }), // Changed to card membership for ID Card
                  ],
                ),
              ],
            ),
          ),

          // Details Section
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _infoSection("Email", Icons.email, [
                  _infoItem("Official", "michael.mitc@example.com"),
                  _infoItem("Personal", "michael@example.com"),
                ]),
                _infoSection("Phone number", Icons.phone, [
                  _infoItem("Mobile", "(209) 555-0104"),
                ]),
                _infoSection("Team", Icons.group, [
                  _infoItem("Project Operation Team", ""),
                ]),
                _infoSection("Leads by", Icons.person, [
                  _infoItem("Darrell Steward", ""),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to show a dialog with provided title and content
  void _showDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Widget _infoSection(String title, IconData icon, List<Widget> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.black45),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...items,
        ],
      ),
    );
  }

  Widget _infoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value.isEmpty ? "Not Available" : value,
            style: const TextStyle(color: Colors.black45),
          ),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon, String label, [VoidCallback? onPressed]) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 25,
            child: Icon(icon, color: Colors.black),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500, // Slightly bolder text for consistency
            color: Colors.white, // Ensure the text stands out
          ),
        ),
      ],
    );
  }
}
