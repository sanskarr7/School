import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChangeProfileScreen extends StatefulWidget {
  const ChangeProfileScreen({super.key});

  @override
  _ChangeProfileScreenState createState() => _ChangeProfileScreenState();
}

class _ChangeProfileScreenState extends State<ChangeProfileScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  final _supabaseClient = Supabase.instance.client;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Load user data from Supabase
  Future<void> _loadUserData() async {
    final user = _supabaseClient.auth.currentUser;
    if (user != null) {
      setState(() {
        userEmail = user.email;
        // You can fetch additional data like name, phone, etc. from your database here
      });
    }
  }

  // Function to update user password
  Future<void> _updatePassword() async {
    final newPassword = _passwordController.text.trim();

    if (newPassword.isNotEmpty) {
      try {
        final user = _supabaseClient.auth.currentUser;

        if (user != null) {
          final updateResponse = await _supabaseClient.auth.updateUser(
            UserAttributes(password: newPassword),
          );

          if (updateResponse.error == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Password updated successfully!")),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Error updating password")),
            );
          }
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password cannot be empty")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Create your Profile",
          style: TextStyle(
            color: Color.fromARGB(255, 8, 8, 8),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 5, 5, 5)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  'https://via.placeholder.com/150'), // Placeholder image
            ),
            const SizedBox(height: 20),
            // Name field (unchangeable)
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: "Name",
              ),
              enabled: false, // Disable editing
            ),
            const SizedBox(height: 15),
            // Email field (unchangeable, dynamic display)
            TextField(
              controller: TextEditingController(text: userEmail), // Display the email dynamically
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: "Login Email",
              ),
              enabled: false, // Disable editing
            ),
            const SizedBox(height: 15),
            // Phone field (unchangeable)
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: "Phone Number",
              ),
              enabled: false, // Disable editing
            ),
            const SizedBox(height: 15),
            // Password field (changeable)
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: "Change Your Password",
              ),
              obscureText: true,
            ),
            const SizedBox(height: 30),
            // Save Changes button
           ElevatedButton(
  onPressed: _updatePassword,
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF60B8AF), // Replaces 'primary'
    foregroundColor: Colors.white, // Sets the text color to white
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
  ),
  child: const Text(
    "Save Changes",
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  ),
),

          ],
        ),
      ),
      backgroundColor: const Color(0xFFF6F6F6),
    );
  }
}

extension on UserResponse {
  get error => null;
}
