import 'package:flutter/material.dart';
import 'package:pl2_kasir/pages/login_pages.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  void _signOut(){
    Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          AppBar(
            title: const Text('Welcome to Dashboard'),
            actions: [
              IconButton( icon: const Icon(Icons.logout), 
              onPressed: _signOut,
              )
            ],
          )
        ],
      ) ,
    );
  }
}