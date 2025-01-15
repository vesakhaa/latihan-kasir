import 'package:flutter/material.dart';
import 'package:pl2_kasir/component/bottom_nav_bar.dart';
import 'package:pl2_kasir/pages/cart_page.dart';
import 'package:pl2_kasir/pages/dashboard.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //navigate

  int _selectedIndex = 0;
  void navigateBottomBar(int index) {
    setState((){
      _selectedIndex = index;
    });
  }

  //pages
  final List<Widget> _pages = [
    const Dashboard(),

    const CartPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index) ,
      ),
      body: _pages[_selectedIndex],  // Change the body based on the selected tab index.
    );
  }
}