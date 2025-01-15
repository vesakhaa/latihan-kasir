import 'package:flutter/material.dart';
import 'package:pl2_kasir/pages/dashboard.dart';
import 'package:pl2_kasir/pages/login_pages.dart';
import 'package:pl2_kasir/pages/profile_pages.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      //listen to auth state change
    stream: Supabase.instance.client.auth.onAuthStateChange,  

    //build appropriatepage based on auth state 
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator(),),
        );
      }

      //cek validasi session
      final session = snapshot.hasData ? snapshot.data!.session : null;

      if (session != null) {
        return const Dashboard();
      } else {
        return const LoginPage();
      }
    }
    );
  }
}