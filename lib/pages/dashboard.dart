import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pl2_kasir/component/bottom_nar_bar.dart';
import 'package:pl2_kasir/pages/cart_page.dart';
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
  int _selectedIndex = 0;
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List <Widget> _pages = [
    const Dashboard(),

    const CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
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

      body: 
      Padding(padding: const EdgeInsets.all(20),
      

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Welcome, Mas Azril", style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFF00934E),
                
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  )
                ],
              ),
            )
          ],

    
          
        ),
        
        

        
      )
    );
  }
}