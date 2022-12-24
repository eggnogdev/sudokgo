import 'package:supabase_flutter/supabase_flutter.dart';

class SudokGoApi {
  const SudokGoApi();

  static final supabase = Supabase.instance.client;

  static Future<void> login(String email) async {
    await supabase.auth.signInWithOtp(
      email: email,
      shouldCreateUser: true,
      emailRedirectTo: 'com.danielegorov.sudokgo://login-callback/',
    );
  }
}
