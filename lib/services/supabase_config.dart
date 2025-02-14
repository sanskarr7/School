import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseClient supabase = Supabase.instance.client;

  // Sign in function
  Future<String?> signIn(String email, String password) async {
    try {
      return null; // Success, no error message
    } catch (error) {
      return error.toString(); // Return error message
    }
  }

  // Sign out function
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }
}
