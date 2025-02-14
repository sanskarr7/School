import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (response.user != null) {
        //  Login Successful - Navigate to HomePage
        Navigator.pushReplacementNamed(context, '/home');
      }
    } on AuthException catch (e) {
      //  Show error if login fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 100),
            _buildWelcomeSection(),
            const SizedBox(height: 48),
            _buildLoginForm(),
            const SizedBox(height: 24),
            // _buildRememberMeSection(),
            const SizedBox(height: 32),
            _buildSignInButton(),
            const SizedBox(height: 24),
            _buildForgotPassword(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      children: [
        const Text('Welcome',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600)),
        const Text('Back!',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Text('Continue your Journy with Edu360.',
            style: TextStyle(fontSize: 16, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            hintText: 'Email',
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Password',
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          ),
        ),
      ],
    );
  }

  // Widget _buildRememberMeSection() {
  //   return Row(
  //     children: [
  //       Checkbox(
  //         value: _rememberMe,
  //         onChanged: (value) => setState(() => _rememberMe = value!),
  //       ),
  //       Text('Remember me', style: TextStyle(color: Colors.grey[600])),
  //     ],
  //   );
  // }

  Widget _buildSignInButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _signIn, // Disable button if loading
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF73BDB6),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: _isLoading
            ? const CircularProgressIndicator(
                color: Color.fromARGB(
                    255, 14, 13, 13)) // Show loading indicator
            : const Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 32, 32, 32),
                ),
              ),
      ),
    );
  }

  Widget _buildForgotPassword() {
    return TextButton(
      onPressed: () async {
        if (_emailController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Enter email to reset password"),
                backgroundColor: Colors.red),
          );
          return;
        }

        try {
          await Supabase.instance.client.auth
              .resetPasswordForEmail(_emailController.text.trim());
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Password reset email sent"),
                backgroundColor: Colors.green),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text("Error: ${e.toString()}"),
                backgroundColor: Colors.red),
          );
        }
      },
      child: const Text('Forgot password?',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600)),
    );
  }
}
