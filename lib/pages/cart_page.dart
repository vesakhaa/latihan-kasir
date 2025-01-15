import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_pages.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  void _signOut(){
    Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(           
            title: Text('Menu', style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold),),
            centerTitle: true,
            // backgroundColor: const Color(0xFF00934E),
            actions: [
              IconButton( icon: const Icon(Icons.person, color: Colors.black), 
              onPressed: _signOut,
              )
            ],
          ),
    );
  }
}