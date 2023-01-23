import 'package:sudokgo/src/hive/hive_wrapper.dart';
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

  static Session? session() {
    return supabase.auth.currentSession;
  }

  static Future<void> logout() async {
    await supabase.auth.signOut();
  }

  /// Create the user row in the users table
  /// 
  /// perform an upsert on the users table to either create or update the current
  /// users row in the table which will ensure they have a row in the table and
  /// that the `display_name` property in the table is in sync with the display
  /// name stored in the [Hive]
  static Future<void> upsertUserRow() async {
    await supabase.from('users')
      .upsert({
        'created_at': supabase.auth.currentUser?.createdAt,
        'id': supabase.auth.currentUser?.id,
        'email': supabase.auth.currentUser?.email,
        'display_name': HiveWrapper.getDisplayName(),
      });
  }
}
