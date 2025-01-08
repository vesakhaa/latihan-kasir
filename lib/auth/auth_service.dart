import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  //sign in witg email, password

  Future<AuthResponse> signInWithEmailAndPassword(String email, String password) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password);
  }

  //sign up with email password

  Future<AuthResponse> signUpWithEmailAndPassword( String email, String password) async{
    return await _supabase.auth.signUp(
      email: email,
      password: password);
  }

  //sign out

  Future<void> signOut() async{
    return await _supabase.auth.signOut();
  }

  //get user email

  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }
} 
