import 'package:flutter/material.dart';
import 'package:pl2_kasir/auth/auth_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://xmvlyaqvwiwiwtsteilm.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inhtdmx5YXF2d2l3aXd0c3RlaWxtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzYxMzAxNzEsImV4cCI6MjA1MTcwNjE3MX0.95mVkZ0xtrENN_hpPLz6uo-fNKyg9nIhJ6ueP2wChNA',
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(       
      ),
    );
  }
}
